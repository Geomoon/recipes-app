package config

import (
	"log"
	"os"
	"recipes-api/api"
	"recipes-api/database"

	"github.com/joho/godotenv"
)

type AppConfig struct {
	ImgServer string
}

func (app *AppConfig) Init() {
	LoadEnvVariables()

	host := os.Getenv("DB_HOST")
	port := os.Getenv("DB_PORT")
	password := os.Getenv("DB_PASSWORD")
	db := os.Getenv("DB_NAME")
	user := os.Getenv("DB_USER")
	app.ImgServer = os.Getenv("IMG_SERVER")

	dbConfig := database.NewPersistenceConfig()
	dbConfig.InitDB(host, port, password, db, user)

	serverPort := os.Getenv("SERVER_PORT")

	serv := api.NewServer(serverPort, dbConfig.DB)
	serv.Run()
}

func LoadEnvVariables() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("error loading .env")
	}
}
