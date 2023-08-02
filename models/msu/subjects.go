package models

import (
	"log"
	"msu-scholarship/db"
	models "msu-scholarship/models/types"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func GetSubjects(ctx *gin.Context) {
	sub := []models.Subjects{}

	err := db.DB.Raw(`SELECT  p.id, s.fio, p.name, p.semester, p.types, p.grade  FROM students AS s, subjects AS p WHERE p.student_id = s.id order by id;`).Scan(&sub).Error
	if err != nil {
		log.Println("Error in select object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"msg": sub,
	})
}

func CreateSubject(ctx *gin.Context) {
	var subject []models.Subjects
	student_id, err := strconv.Atoi(ctx.Query("student_id"))
	if err != nil {
		log.Println(err.Error())
		return
	}
	name := ctx.Query("name")
	semestr, err := strconv.Atoi(ctx.Query("semestr"))
	if err != nil {
		log.Println(err.Error())
		return
	}
	types := ctx.Query("types")
	grade, err := strconv.Atoi(ctx.Query("grade"))
	if err != nil {
		log.Println(err.Error())
		return
	}

	err = db.DB.Raw(`INSERT INTO subjects(Student_Id, Name, Semester, Types, Grade)  VALUES($1, $2, $3, $4, $5)`, student_id, name, semestr, types, grade).Scan(&subject).Error
	if err != nil {
		log.Println("Error in select object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"message": "ok",
	})
}

func UpdateSubject(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Query("id"))
	if err != nil {
		log.Println(err.Error())
	}
	name := ctx.Query("name")
	semestr, err := strconv.Atoi(ctx.Query("semester"))
	if err != nil {
		log.Println(err.Error())
	}
	types := ctx.Query("types")
	grade, err := strconv.Atoi(ctx.Query("grade"))
	if err != nil {
		log.Println(err.Error())
		return
	}

	subject := []models.Subjects{}

	err = db.DB.Raw("UPDATE subjects SET  name = $1, semester = $2,  types = $3, grade = $4  where id = $5", name, semestr, types, grade, id).Scan(&subject).Error
	if err != nil {
		log.Println("Error in update object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"message": "update correct",
	})
}

func EditSubject(ctx *gin.Context) {
	subject := []models.Subjects{}
	id := ctx.Param("id")

	err := db.DB.Raw(`SELECT  p.id, s.fio, p.name, p.semester, p.types, p.grade  FROM students AS s, subjects AS p WHERE p.student_id = s.id and p.id = ?;`, id).Scan(&subject).Error
	if err != nil {
		log.Println("Error in select object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"message": subject,
	})
}

// delete subject
func DeleteSubject(ctx *gin.Context) {
	subj_id := ctx.Param("id")
	std := []models.Subjects{}

	err := db.DB.Raw(`DELETE FROM subjects WHERE Id = $1`, subj_id).Scan(&std).Error
	if err != nil {
		log.Println("Error in select object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}

	ctx.JSON(http.StatusOK, gin.H{
		"message": "Успешно удалено!",
	})
}
