package recipe

import (
	recipeingredient "recipes-api/pkg/recipe_ingredient"
	recipestep "recipes-api/pkg/recipe_step"
	recipetype "recipes-api/pkg/recipe_type"
	"time"
)

type GetRecipeDTO struct {
	ID          string                                 `json:"id"`
	Name        string                                 `json:"name"`
	NumPortions uint8                                  `json:"numPortions"`
	Img         string                                 `json:"img"`
	Time        uint                                   `json:"time"`
	CreatedAt   *time.Time                             `json:"createdAt"`
	Type        recipetype.RecipeTypeDTO               `json:"type"`
	Ingredients []recipeingredient.RecipeIngredientDTO `json:"ingredients"`
	Steps       []recipestep.GetStepDTO                `json:"steps"`
}

type GetRecipeSimpleDTO struct {
	ID          string                   `json:"id"`
	Name        string                   `json:"name"`
	Img         string                   `json:"img"`
	NumPortions uint8                    `json:"numPortions"`
	CreatedAt   *time.Time               `json:"createdAt"`
	Type        recipetype.RecipeTypeDTO `json:"type"`
}

type CreateRecipeDTO struct {
	Name        string                                 `json:"name"`
	NumPortions uint8                                  `json:"numPortions"`
	Img         string                                 `json:"img"`
	Type        recipetype.RecipeTypeDTO               `json:"type"`
	Ingredients []recipeingredient.CreateIngredientDTO `json:"ingredients"`
	Steps       []recipestep.CreateStepDTO             `json:"steps"`
}

type GetAllByTypeDTO struct {
	Type    recipetype.RecipeTypeDTO `json:"type"`
	Recipes []GetRecipeListDTO       `json:"recipes"`
}

type GetRecipeListDTO struct {
	ID          string    `json:"id"`
	Name        string    `json:"name"`
	Img         string    `json:"img"`
	NumPortions uint      `json:"numPortions"`
	Time        uint      `json:"time"`
	CreatedAt   time.Time `json:"createdAt"`
}
