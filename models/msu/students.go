package models

import (
	"fmt"
	"log"
	"msu-scholarship/db"
	models "msu-scholarship/models/types"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func GetStudents(ctx *gin.Context) {
	scholar := []models.Students{}
	database, err := db.GetConnect()
	if err != nil {
		log.Println("Error in connect to db ==> ", err.Error())
	}
	err = database.Raw(`SELECT s.id, s.fio, s.record_number, d.number, s.kurs, to_char(s.birth_date,'DD.MM.YYYY') as "birth_date", s.city, s.number_Phone, ss.category  FROM students AS s, groups AS d, scholarship as ss  WHERE s.number = d.id and s.scholarship = ss.id ORDER BY id`).Scan(&scholar).Error
	if err != nil {
		log.Println("Error in select object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"message": scholar,
	})
}
func Edit(ctx *gin.Context) {
	scholar := []models.Students{}
	id := ctx.Param("id")
	database, err := db.GetConnect()
	if err != nil {
		log.Println("Error in connect to db ==> ", err.Error())
	}
	err = database.Raw(`SELECT  * FROM students WHERE id = $1`, id).Scan(&scholar).Error
	if err != nil {
		log.Println("Error in select object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"message": scholar,
	})
}

func DeleteStudentById(ctx *gin.Context) {
	stud_id := ctx.Param("id")
	std := []models.Students{}

	err := db.DB.Raw(`DELETE FROM STUDENTS WHERE Id = $1`, stud_id).Scan(&std).Error
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
func CreateStudent(ctx *gin.Context) {
	id := ctx.Query("id")
	fio := ctx.Query("fio")
	record_Number, err := strconv.Atoi(ctx.Query("record_Number"))
	if err != nil {
		log.Println(err.Error())
	}
	number, err := strconv.Atoi(ctx.Query("number"))
	if err != nil {
		log.Println(err.Error())
	}
	birth_Date := ctx.Query("birth_Date")
	city := ctx.Query("city")
	number_Phone := ctx.Query("number_Phone")
	scholarship, err := strconv.Atoi(ctx.Query("scholarship"))
	if err != nil {
		log.Println(err.Error())
	}
	kurs, err := strconv.Atoi(ctx.Query("kurs"))
	if err != nil {
		log.Println(err.Error())
	}
	std := []models.ForCreateStudents{}

	err = db.DB.Raw("INSERT INTO Students VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9)", id, fio, record_Number, number, birth_Date, city, number_Phone, scholarship, kurs).Scan(&std).Error
	if err != nil {
		log.Println("Error in create object ==> ", err.Error())
		ctx.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
	}
	ctx.JSON(http.StatusOK, gin.H{
		"message": std,
	})
}

func UpdateStudents(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Query("id"))
	if err != nil {
		log.Println(err.Error())
	}
	fio := ctx.Query("fio")
	record_Number, err := strconv.Atoi(ctx.Query("record_Number"))
	if err != nil {
		log.Println(err.Error())
	}
	number, err := strconv.Atoi(ctx.Query("number"))
	if err != nil {
		log.Println(err.Error())
	}
	birth_Date := ctx.Query("birth_Date")
	city := ctx.Query("city")
	number_Phone := ctx.Query("number_Phone")
	kurs, err := strconv.Atoi(ctx.Query("kurs"))
	if err != nil {
		log.Println(err.Error())
	}
	std := []models.Students{}

	err = db.DB.Raw("UPDATE students SET Fio = $1 , Record_Number = $2, Number = $3,  Birth_Date = $4, City = $5 , Number_Phone = $6, kurs = $7 where id=$8", fio, record_Number, number, birth_Date, city, number_Phone, kurs, id).Scan(&std).Error
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

func UpdateStudentByFio(ctx *gin.Context) {

	fio := ctx.Query("fio")
	scholarship, err := strconv.Atoi(ctx.Query("scholarship"))
	if err != nil {
		log.Println(err.Error())
	}
	std := []models.Students{}

	err = db.DB.Raw("UPDATE students SET scholarship = $1 WHERE fio = $2", scholarship, fio).Scan(&std).Error
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

func SortStudentByID(c *gin.Context) {
	var std models.Students
	err := c.Bind(&std)
	if err != nil {
		log.Print("Error in get from body object ==> ", err.Error())
		return
	}
	student := []models.Students{}

	err = db.DB.Raw("SELECT * FROM students ORDER BY Id desc").Scan(&student).Error
	if err != nil {
		log.Print(err.Error())
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
		return
	}
	c.JSON(http.StatusOK, gin.H{"sortStudentsById": student})
}

func SortStudentByFio(c *gin.Context) {
	var std models.Students
	err := c.Bind(&std)
	if err != nil {
		log.Print("Error in get from body object ==> ", err.Error())
		return
	}
	student := []models.Students{}

	err = db.DB.Raw("SELECT * FROM students ORDER BY fio").Scan(&student).Error
	if err != nil {
		log.Print(err.Error())
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
		return
	}
	c.JSON(http.StatusOK, gin.H{"sortStudentsByFio": student})
}

func SortStudentByCategories(c *gin.Context) {
	var std models.Students
	err := c.Bind(&std)
	if err != nil {
		log.Print("Error in get from body object ==> ", err.Error())
		return
	}
	student := []models.Students{}

	err = db.DB.Raw("SELECT * FROM students ORDER BY Category").Scan(&student).Error
	if err != nil {
		log.Print(err.Error())
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err,
		})
		return
	}
	c.JSON(http.StatusOK, gin.H{"sort students by category": student})
}

func GetByFio(c *gin.Context) {
	searchText := c.Query("fio")
	std := []models.Students{}

	log.Println("1")
	err := db.DB.Raw(`SELECT s.id, s.fio, s.record_number, d.number, s.kurs , to_char(s.birth_date,'DD.MM.YYYY') as "birth_date", s.city, s.number_Phone, ss.category
	FROM students AS s, groups AS d, scholarship as ss
	WHERE (s.number = d.id AND s.scholarship = ss.id) AND (s.fio ILIKE $1 OR s.city ILIKE $1 OR s.number_Phone ILIKE $1 OR d.number ILIKE $1) order by id;
	 `, fmt.Sprint("%", searchText, "%")).Scan(&std).Error
	if err != nil {
		log.Println(err.Error())
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}
	log.Println("2")
	c.JSON(http.StatusOK, gin.H{
		"response": std,
	})
}
