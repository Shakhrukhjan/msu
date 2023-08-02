package models

import (
	"github.com/gin-gonic/gin"
	"log"
	"msu-scholarship/db"
	models "msu-scholarship/models/types"
	"net/http"
)

func GetAllFaculties(ctx *gin.Context) {
	std := []models.Faculties{}

	err := db.DB.Raw("select * from faculties").Scan(&std).Error
	if err != nil {
		log.Println("Error in select object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"Message": std,
	})
}
