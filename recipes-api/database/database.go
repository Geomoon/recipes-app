package database

import (
	"fmt"
	"log"
	"os"
	"time"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

type persistenceConfig struct {
	DB *gorm.DB
}

func NewPersistenceConfig() persistenceConfig {
	return persistenceConfig{}
}

func (p *persistenceConfig) InitDB(host, user, password, database, port string) {
	var err error
	logger := initLogger()

	dsn := "host=%s user=%s password=%s dbname=%s port=%s sslmode=disable"
	dsnString := fmt.Sprintf(dsn, host, port, password, database, user)

	p.DB, err = gorm.Open(postgres.Open(dsnString), &gorm.Config{
		Logger: logger,
	})

	if err != nil {
		panic("Failed to connect database")
	}
	log.Println("Database connected!")

}

func initLogger() logger.Interface {
	return logger.New(
		log.New(os.Stdout, "\r\n", log.LstdFlags), // io writer
		logger.Config{
			SlowThreshold:             time.Second, // Slow SQL threshold
			LogLevel:                  logger.Info, // Log level
			IgnoreRecordNotFoundError: true,        // Ignore ErrRecordNotFound error for logger
			Colorful:                  true,        // Disable color
		},
	)
}
