package recipeingredient

type CreateIngredientDTO struct {
	Description  string  `json:"description"`
	Quantity     float32 `json:"quantity"`
	QuantityType string  `json:"quantityType"`
	RecipeID     string  `json:"recipeId"`
}

type RecipeIngredientDTO struct {
	ID           string  `json:"id"`
	Description  string  `json:"description"`
	Quantity     float32 `json:"quantity"`
	QuantityType string  `json:"quantityType"`
}
