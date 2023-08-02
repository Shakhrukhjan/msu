package models

import (
	"github.com/gin-gonic/gin"
	"log"
	"msu-scholarship/db"
	models "msu-scholarship/models/types"
	"net/http"
)

func GetScholarship(ctx *gin.Context) {
	scholar := []models.Scholarship{}

	err := db.DB.Raw("SELECT * FROM scholarship").Scan(&scholar).Error
	if err != nil {
		log.Println("Error in select object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"message": scholar,
	})
}

func CreateScholarship(ctx *gin.Context) {
	var stipend models.Scholarship
	err := ctx.Bind(&stipend)
	if err != nil {
		log.Println("Error in get from body object ==> ", err.Error())
		return
	}
	scholar := []models.Scholarship{}

	err = db.DB.Raw("INSERT INTO scholarship(Category,Discription, Summa) VALUES($1, $2, $3)", stipend.Category, stipend.Description, stipend.Summa).Scan(&scholar).Error
	if err != nil {
		log.Println("Error in create object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"message": scholar,
	})
}
