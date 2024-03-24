package recipe

type Repository interface {
	GetAll() ([]Recipe, error)
	GetByID(id string) (Recipe, error)
	GetAllByType(retyId string) ([]GetRecipeListDTO, error)
	Save(recipe Recipe) (string, error)
	Delete(id string) error
}
