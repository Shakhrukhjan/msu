package main

import (
	"log"
	"msu-scholarship/db"
	"msu-scholarship/routes"
)

func main() {
	_, err := db.GetConnect()
	if err != nil {
		log.Printf("%v in connect to db", err.Error())
		return
	}
	routes.ListenAndRun()
}
