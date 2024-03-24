package recipestep

import "recipes-api/pkg/types"

type Repository interface {
	SaveAll(recipes []RecipeStep) error
	Save(recipe RecipeStep) (types.IdDTO, error)
	DeleteByID(id string) error
	DeleteByRecipe(recipeId string) error
	Update(id string, recipe RecipeStep) error
}
