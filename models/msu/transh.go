package models

import (
	"log"
	"msu-scholarship/db"
	models "msu-scholarship/models/types"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func CreateTransh(ctx *gin.Context) {
	summa, err := strconv.Atoi(ctx.Query("summa"))
	if err != nil {
		log.Print(err)
		return
	}
	date := ctx.Query("date")
	std := []models.Transh{}

	err = db.DB.Raw("INSERT INTO transaction(summa, date) VALUES($1, $2)", summa, date).Scan(&std).Error
	if err != nil {
		log.Println("Error in create object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"message": "Успешно добавлено",
	})
}

func GetTransh(ctx *gin.Context) {
	std := []models.Transh{}

	err := db.DB.Raw(`select * from transaction`).Scan(&std).Error
	if err != nil {
		log.Println("Error in create object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"mes": std,
	})
}

func DeleteTransh(ctx *gin.Context) {
	id := ctx.Param("id")
	std := []models.Transh{}

	err := db.DB.Raw(`DELETE from transaction WHERE id = $1`, id).Scan(&std).Error
	if err != nil {
		log.Println("Error in delete object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"message": "успешно удалено",
	})
}

func UpdateTransh(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Query("id"))
	if err != nil {
		log.Print(err.Error())
		return
	}
	summa, err := strconv.Atoi(ctx.Query("summa"))
	if err != nil {
		log.Print(err.Error())
		return
	}
	date := ctx.Query("date")
	std := []models.Transh{}

	err = db.DB.Raw(`UPDATE transaction SET summa = $1, date = $2 WHERE id = $1`, summa, date, id).Scan(&std).Error
	if err != nil {
		log.Println("Error in update object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"message": "update corrected",
	})
}
