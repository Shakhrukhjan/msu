package models

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func (u *User) AuthMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		// Получаем токен из заголовка запроса
		token := c.GetHeader("Authorization")
		if token == "" {
			c.JSON(http.StatusUnauthorized, gin.H{
				"error": "Unauthorized",
			})
			c.Abort()
			return
		}
		// Проверяем, что токен верный
		isValidToken := checkTokenValidity(token)
		if !isValidToken {
			c.JSON(http.StatusUnauthorized, gin.H{
				"error": "Invalid token",
			})
			c.Abort()
			return
		}
		c.Next()
	}
}
func checkTokenValidity(token string) bool {
	validToken := ValidToken
	return token == validToken
}
