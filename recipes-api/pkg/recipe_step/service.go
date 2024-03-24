package recipestep

type Service struct {
	repo *Repository
}

func NewService(repo *Repository) *Service {
	return &Service{
		repo: repo,
	}
}

func (serv *Service) SaveAll(steps []CreateStepDTO) error {
	entities := CreateDTOListToEntity(steps)
	return (*serv.repo).SaveAll(entities)
}

func (serv *Service) DeleteByID(id string) error {
	return (*serv.repo).DeleteByID(id)
}

func (serv *Service) Update(id string, recipe CreateStepDTO) error {
	entity := CreateDTOToEntity(recipe)
	return (*serv.repo).Update(id, entity)
}

func (serv *Service) DeleteByRecipe(recipeId string) error {
	return (*serv.repo).DeleteByRecipe(recipeId)
}
