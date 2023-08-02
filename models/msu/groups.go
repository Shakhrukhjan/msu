package models

import (
	"github.com/gin-gonic/gin"
	"log"
	"msu-scholarship/db"
	models "msu-scholarship/models/types"
	"net/http"
)

func GetAllGroups(ctx *gin.Context) {
	msuGroups := []models.Groups{}
	err := db.DB.Raw("select  s.id, s.number, f.name , s.year_creat from groups as s, faculties as f  where s.faculty_id=f.Id").Scan(&msuGroups).Error
	if err != nil {
		log.Println("Error in select object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"mess": msuGroups,
	})
}
