package recipestep

type CreateStepDTO struct {
	Description string `json:"description"`
	Order       uint8  `json:"order"`
	Time        uint64 `json:"time"`
	RecipeID    string `json:"recipeId"`
}

type GetStepDTO struct {
	ID          string `json:"id"`
	Description string `json:"description"`
	Order       uint8  `json:"order"`
	Time        uint64 `json:"time"`
}
