package main

import (
	"recipes-api/config"
)

func main() {
	app := config.AppConfig{}
	app.Init()
}
