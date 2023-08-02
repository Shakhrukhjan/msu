package models

import (
	"crypto/md5"
	"encoding/hex"
	"errors"
	"fmt"
	"github.com/dgrijalva/jwt-go"
	"log"
	"msu-scholarship/db"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
)

type User struct {
	Id       int64     `json:"id"`
	Name     string    `json:"name"`
	Email    string    `json:"email"`
	Password string    `json:"password"`
	Created  time.Time `json:"created"`
}

var ErrSuchUser = errors.New("no such user")
var ErrInvalidPassword = errors.New("invalid password")
var ErrInternal = errors.New("internal error")
var ValidToken string

func (u *User) RegisterUser(name, email, password string) (string, error) {
	var user User

	err := db.DB.Raw("INSERT INTO users(name, email, password) VALUES($1, $2, $3) RETURNING name", name, email, password).Scan(&user).Error
	if err != nil {
		log.Println("Error in create object ==> ", err.Error())
		return "", err
	}
	return user.Name, nil
}
func (u *User) SignUp(ctx *gin.Context) {
	name := ctx.Query("name")
	login := ctx.Query("email")
	password := ctx.Query("password")

	// hash for password
	hash := md5.New()
	_, err := hash.Write([]byte(password))
	if err != nil {
		log.Println(err)
		os.Exit(1)
	}
	slp := hash.Sum([]byte(nil))
	hashPassword := hex.EncodeToString(slp)

	userName, err := u.RegisterUser(name, login, hashPassword)
	if err != nil {
		log.Println(err.Error())
		ctx.JSON(http.StatusBadRequest, "Пользователь уже зарегистрирован!")
	} else {
		ctx.JSON(http.StatusOK, gin.H{
			"message": "Пользователь" + " " + userName + " " + "успешно зарегистрировано!",
		})
	}
}

func (u *User) TokenForUser(email string, password string) (tokenString string, tokenExp int64, err error) {
	err = db.DB.Raw("SELECT id, password FROM users WHERE email = $1", email).Scan(&u).Error
	if err != nil {
		log.Println(err.Error())
		return "", 0, ErrSuchUser
	}

	// Создание нового токена
	token := jwt.New(jwt.SigningMethodHS256)
	claims := token.Claims.(jwt.MapClaims)
	claims["login"] = email
	claims["password"] = password
	claims["exp"] = time.Now().Add(time.Minute * 1).Unix() // Установка срока действия токена в секундах
	// Подпись токена с использованием секретного ключа
	secretKey := []byte("mySecretKey") // Секретный ключ
	tokenString, err = token.SignedString(secretKey)
	if err != nil {
		fmt.Println("Ошибка при подписи токена:", err)
		return "", 0, err
	}
	err = db.DB.Exec("INSERT INTO users_tokens(user_id) VALUES($1)", u.Id).Error
	if err != nil {
		return "", 0, ErrInternal
	}
	tokenExp = time.Now().Add(time.Minute * 1).Unix() // Время окончания действия токена в секундах
	return tokenString, tokenExp, nil
}
func (u *User) GenerateToken(ctx *gin.Context) {
	email := ctx.Query("email")
	password := ctx.Query("password")
	token, expire, err := u.TokenForUser(email, password)
	ValidToken = token
	if err != nil {
		ctx.JSON(http.StatusUnprocessableEntity, gin.H{
			"message": "Пользователь не зарегистрированно!",
			"code":    400,
		})
		ctx.Abort()
	} else {
		ctx.JSON(http.StatusOK, gin.H{
			"accessToken": token,
			"exp":         expire,
		})
	}
}

func (u *User) Auth(c *gin.Context) {
	authHeader := c.GetHeader("Authorization")
	// Проверка наличия токена в заголовке
	if authHeader == "" {
		c.JSON(http.StatusUnauthorized, gin.H{
			"message": "Отсутствует заголовок Authorization",
			"code":    400,
		})
		c.Abort()
		return
	}
	tokenParts := strings.Split(authHeader, " ")
	if len(tokenParts) != 2 || tokenParts[0] != "Bearer" {
		c.JSON(http.StatusUnauthorized, gin.H{
			"message": "Неверный формат токена",
			"code":    405,
		})
		c.Abort()
		return
	}
	token := tokenParts[1]
	secretKey := []byte("mySecretKey") // Секретный ключ, должен совпадать с ключом, используемым при создании токена
	claims := jwt.MapClaims{}
	tok, err := jwt.ParseWithClaims(token, claims, func(token *jwt.Token) (interface{}, error) {
		return secretKey, nil
	})
	if err != nil {
		if err == jwt.ErrSignatureInvalid {
			c.JSON(http.StatusUnauthorized, gin.H{
				"message": "Неверная подпись токена",
				"code":    402,
			})
		} else {
			c.JSON(http.StatusBadRequest, gin.H{
				"message": "Неверный токен",
				"code":    401,
			})
		}
		c.Abort()
		return
	}
	if !tok.Valid {
		c.JSON(http.StatusUnauthorized, gin.H{
			"message": "Невалидный токен",
			"code":    403,
		})
		c.Abort()
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"message": "Запрос успешно выполнен",
		"code":    200,
	})
}
