package recipeingredient

import "recipes-api/pkg/types"

type Service struct {
	repo *Repository
}

func NewService(repo *Repository) *Service {
	return &Service{
		repo: repo,
	}
}

func (serv *Service) SaveAll(ingredients []CreateIngredientDTO) error {
	entities := CreateDTOListToEntity(ingredients)
	return (*serv.repo).SaveAll(entities)
}

func (serv *Service) Save(ingredient CreateIngredientDTO) (types.IdDTO, error) {
	entity := CreateDTOToEntity(ingredient)
	return (*serv.repo).Save(entity)
}

func (serv *Service) DeleteById(id string) error {
	return (*serv.repo).Delete(id)
}

func (serv *Service) Update(id string, ingredient CreateIngredientDTO) error {
	entity := CreateDTOToEntity(ingredient)
	_, err := (*serv.repo).Update(id, entity)
	return err
}

func (serv *Service) GetByRecipe(recipeId string) ([]RecipeIngredientDTO, error) {
	ingredientes, err := (*serv.repo).GetByRecipe(recipeId)
	if err != nil {
		return []RecipeIngredientDTO{}, err
	}
	return EntityListToDTO(ingredientes), nil
}

func (serv *Service) DeleteByRecipe(recipeId string) error {
	return (*serv.repo).DeleteByRecipe(recipeId)
}
