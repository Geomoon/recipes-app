package recipetype

import "errors"

type Service struct {
	repo *Repository
}

func NewService(repo *Repository) *Service {
	return &Service{
		repo: repo,
	}
}

func (serv *Service) GetAll() ([]RecipeTypeDTO, error) {
	list, err := (*serv.repo).GetAll()

	if err != nil {
		return []RecipeTypeDTO{}, errors.New("error: get all recipe types")
	}

	return EntityListToDTO(list), nil
}

func (serv *Service) ExistsByID(id string) (bool, error) {
	return (*serv.repo).ExistsByID(id)
}

func (serv *Service) GetByID(id string) (RecipeTypeDTO, error) {
	recipe, err := (*serv.repo).GetByID(id)
	if err != nil {
		return RecipeTypeDTO{}, err
	}
	return EntityToDTO(recipe), nil
}
