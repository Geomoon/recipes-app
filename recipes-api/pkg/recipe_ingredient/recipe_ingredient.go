package recipeingredient

import (
	"time"
)

type RecipeIngredient struct {
	ID           string     `gorm:"primary_key;column:rein_uuid;default:gen_random_uuid()"`
	Description  string     `gorm:"column:rein_description"`
	Quantity     float32    `gorm:"column:rein_quantity"`
	QuantityType string     `gorm:"column:rein_quantity_type"`
	CreatedAt    *time.Time `gorm:"column:created_at;default:now()"`
	UpdatedAt    *time.Time `gorm:"column:updated_at"`

	RecipeID string `gorm:"column:reci_uuid"`
}

func (RecipeIngredient) TableName() string {
	return "recipe_ingredients"
}
