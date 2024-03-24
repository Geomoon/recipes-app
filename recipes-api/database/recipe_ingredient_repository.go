package database

import (
	recipeingredient "recipes-api/pkg/recipe_ingredient"
	"recipes-api/pkg/types"

	"gorm.io/gorm"
)

type RecipeIngredientRepository struct {
	db *gorm.DB
}

func NewRecipeIngredientRepository(repo *gorm.DB) recipeingredient.Repository {
	return &RecipeIngredientRepository{
		db: repo,
	}
}

func (repo *RecipeIngredientRepository) Delete(id string) error {
	return (*repo.db).Delete(&recipeingredient.RecipeIngredient{ID: id}).Error
}

func (repo *RecipeIngredientRepository) Save(ingredient recipeingredient.RecipeIngredient) (types.IdDTO, error) {
	err := repo.db.Save(&ingredient).Error
	if err != nil {
		return types.IdDTO{}, err
	}
	return types.IdDTO{ID: ingredient.ID}, nil
}

func (repo *RecipeIngredientRepository) SaveAll(ingredients []recipeingredient.RecipeIngredient) error {
	return repo.db.Save(&ingredients).Error
}

func (repo *RecipeIngredientRepository) Update(id string, ingredient recipeingredient.RecipeIngredient) (types.IdDTO, error) {
	err := repo.db.Where("rein_uuid = ?", id).Updates(&ingredient).Error
	if err != nil {
		return types.IdDTO{}, err
	}
	return types.IdDTO{ID: id}, nil
}

func (repo *RecipeIngredientRepository) GetByRecipe(id string) ([]recipeingredient.RecipeIngredient, error) {
	var ingredients []recipeingredient.RecipeIngredient
	err := repo.db.Where("reci_uuid = ?", id).Find(&ingredients).Error
	return ingredients, err
}

func (repo *RecipeIngredientRepository) DeleteByRecipe(recipeId string) error {
	return (*repo.db).Where("reci_uuid = ?", recipeId).Delete(&recipeingredient.RecipeIngredient{}).Error
}
