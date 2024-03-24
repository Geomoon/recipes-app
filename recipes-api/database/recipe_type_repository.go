package database

import (
	"errors"
	recipetype "recipes-api/pkg/recipe_type"
	"recipes-api/pkg/types"

	"gorm.io/gorm"
)

type RecipeTypeRepository struct {
	db *gorm.DB
}

func NewRecipeTypeRepository(db *gorm.DB) recipetype.Repository {
	return &RecipeTypeRepository{
		db: db,
	}
}

func (repo *RecipeTypeRepository) GetAll() ([]recipetype.RecipeType, error) {
	var types []recipetype.RecipeType

	err := repo.db.Order("rety_name").Find(&types).Error
	if err != nil {
		return []recipetype.RecipeType{}, err
	}

	return types, nil
}

func (repo *RecipeTypeRepository) ExistsByID(id string) (bool, error) {
	var count int64
	err := (*repo.db).Table("recipe_types").Where("rety_uuid = ?", id).Count(&count).Error

	if err != nil {
		return false, err
	}
	return count > 0, nil
}

func (repo *RecipeTypeRepository) GetByID(id string) (recipetype.RecipeType, error) {
	var recipeType recipetype.RecipeType
	err := (*repo.db).Where("rety_uuid = ?", id).First(&recipeType).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return recipetype.RecipeType{}, types.NewNotFoundError("type not found")
		}
		return recipetype.RecipeType{}, err
	}
	return recipeType, nil
}
