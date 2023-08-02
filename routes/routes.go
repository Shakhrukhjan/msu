package routes

import (
	"log"
	"msu-scholarship/cors"
	models "msu-scholarship/models/msu"

	"github.com/gin-gonic/gin"
)

func ListenAndRun() {
	var u *models.User
	rout := gin.Default()
	rout.Use(cors.CORSMiddleware())
	rout.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "hello",
		})
	})
	router := rout.Group("/get/students")
	{
		router.GET("/faculties", models.GetAllFaculties)
		router.GET("/groups", models.GetAllGroups)
		router.GET("/scholarships", models.GetScholarship)
		router.GET("/byFio", models.GetByFio)
		router.GET("/subjects", models.GetSubjects)
		router.GET("/all", models.GetStudents)
		router.GET("/transh", models.GetTransh)
	}
	router = rout.Group("/sort/students")
	{
		router.GET("/byId", models.SortStudentByID)
		router.GET("/byFio", models.SortStudentByFio)
		router.GET("/byCategory", models.SortStudentByCategories)
	}
	router = rout.Group("/create")
	{
		router.POST("/student", models.CreateStudent)
		router.POST("/subject", models.CreateSubject)
		router.POST("/scholarship", models.CreateScholarship)
		router.POST("/transh", models.CreateTransh)
	}
	router = rout.Group("/update")
	{
		router.GET("/student/:id", models.Edit)
		router.PUT("/student", models.UpdateStudents)
		router.PUT("/student/byfio", models.UpdateStudentByFio)
		router.GET("/subject/:id", models.EditSubject)
		router.PUT("/subject", models.UpdateSubject)
	}
	router = rout.Group("/delete")
	{
		router.DELETE("/student/:id", models.DeleteStudentById)
		router.DELETE("/subject/:id", models.DeleteSubject)
		router.DELETE("/transh/:id", models.DeleteTransh)
	}
	// идентификация аутентификация и авторизация
	router = rout.Group("/api")
	{
		router.POST("/users", u.SignUp)        // регистрация
		router.POST("/token", u.GenerateToken) // получение токен
		router.POST("/auth", u.Auth)           // авторизация
	}

	rout.POST("/")
	if err := rout.Run(); err != nil {
		log.Printf("%s in run project", err)
	}
}
