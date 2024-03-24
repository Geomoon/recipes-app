package recipeingredient

import "recipes-api/pkg/types"

type Repository interface {
	Save(ingredient RecipeIngredient) (types.IdDTO, error)
	SaveAll(ingredients []RecipeIngredient) error
	Delete(id string) error
	DeleteByRecipe(recipeId string) error
	Update(id string, ingredient RecipeIngredient) (types.IdDTO, error)
	GetByRecipe(recipeId string) ([]RecipeIngredient, error)
}
