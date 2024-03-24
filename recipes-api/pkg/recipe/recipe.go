package recipe

import (
	recipeingredient "recipes-api/pkg/recipe_ingredient"
	recipestep "recipes-api/pkg/recipe_step"
	recipetype "recipes-api/pkg/recipe_type"
	"time"

	"gorm.io/gorm"
)

type Recipe struct {
	ID          string          `gorm:"primary_key;column:reci_uuid;default:gen_random_uuid()"`
	Name        string          `gorm:"column:reci_name"`
	NumPortions uint8           `gorm:"column:reci_num_portions"`
	Img         string          `gorm:"column:reci_img;default:null"`
	CreatedAt   *time.Time      `gorm:"column:created_at;default:now()"`
	UpdatedAt   *time.Time      `gorm:"column:updated_at"`
	DeletedAt   *gorm.DeletedAt `gorm:"column:deleted_at;default:null"`
	Time        uint            `gorm:"-"`

	RetyID      string                              `gorm:"column:rety_uuid"`
	Type        recipetype.RecipeType               `gorm:"foreignKey:rety_uuid;references:rety_uuid"`
	Steps       []recipestep.RecipeStep             `gorm:"foreingKey:RecipeID;references:ID"`
	Ingredients []recipeingredient.RecipeIngredient `gorm:"foreingKey:RecipeID;references:ID"`
}

func (Recipe) TableName() string {
	return "recipes"
}
