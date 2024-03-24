package recipetype

type Repository interface {
	GetAll() ([]RecipeType, error)
	ExistsByID(id string) (bool, error)
	GetByID(id string) (RecipeType, error)
}
