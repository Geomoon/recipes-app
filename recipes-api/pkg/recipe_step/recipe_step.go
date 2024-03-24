package recipestep

import "time"

type RecipeStep struct {
	ID          string     `gorm:"primary_key;column:rest_uuid;default:gen_random_uuid()"`
	Description string     `gorm:"column:rest_description"`
	Time        uint64     `gorm:"column:rest_time;default:0"` // seconds
	Order       uint8      `gorm:"column:rest_order"`
	CreatedAt   *time.Time `gorm:"column:created_at;default:now()"`
	UpdatedAt   *time.Time `gorm:"column:updated_at"`
	RecipeID    string     `gorm:"column:reci_uuid"`
}

func (RecipeStep) TableName() string {
	return "recipe_steps"
}
