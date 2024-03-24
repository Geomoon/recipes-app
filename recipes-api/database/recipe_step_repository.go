package database

import (
	recipestep "recipes-api/pkg/recipe_step"
	"recipes-api/pkg/types"

	"gorm.io/gorm"
)

type RecipeStepRepository struct {
	db *gorm.DB
}

func NewRecipeStepRepository(db *gorm.DB) recipestep.Repository {
	return &RecipeStepRepository{
		db: db,
	}
}

func (repo *RecipeStepRepository) DeleteByID(id string) error {
	return repo.db.Delete(&recipestep.RecipeStep{
		ID: id,
	}).Error
}

func (repo *RecipeStepRepository) Save(recipe recipestep.RecipeStep) (types.IdDTO, error) {
	err := repo.db.Save(&recipe).Error
	if err != nil {
		return types.IdDTO{}, err
	}
	return types.IdDTO{ID: recipe.ID}, nil
}

func (repo *RecipeStepRepository) SaveAll(recipes []recipestep.RecipeStep) error {
	return repo.db.Save(&recipes).Error
}

func (repo *RecipeStepRepository) Update(id string, recipe recipestep.RecipeStep) error {
	return repo.db.
		Where("rest_uuid = ? ", id).
		Updates(recipe).
		Error
}

func (repo *RecipeStepRepository) DeleteByRecipe(recipeId string) error {
	return (*repo.db).Where("reci_uuid = ?", recipeId).Delete(&recipestep.RecipeStep{}).Error
}
