package recipetype

import (
	"time"

	"gorm.io/gorm"
)

type RecipeType struct {
	ID        string          `gorm:"primary_key;column:rety_uuid;default:gen_random_uuid()"`
	Name      string          `gorm:"column:rety_name"`
	CreatedAt *time.Time      `gorm:"column:created_at;default:now()"`
	DeletedAt *gorm.DeletedAt `gorm:"column:deleted_at;default:null"`
}

func (RecipeType) TableName() string {
	return "recipe_types"
}
