package db

import (
	"log"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var DB *gorm.DB

func GetConnect() (*gorm.DB, error) {
	connectionString := "host=localhost port=5432 dbname=msu user=postgres password = humo_postgres sslmode=disable"
	db, err := gorm.Open(postgres.Open(connectionString), &gorm.Config{})
	if err != nil {
		log.Fatalln(err.Error())
	}
	DB = db
	return db, err
}
