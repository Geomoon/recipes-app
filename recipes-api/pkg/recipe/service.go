package recipe

import (
	"errors"
	recipeingredient "recipes-api/pkg/recipe_ingredient"
	recipestep "recipes-api/pkg/recipe_step"
	recipetype "recipes-api/pkg/recipe_type"
	"recipes-api/pkg/types"
	"reflect"
)

type Service struct {
	repo              *Repository
	recipeTypeService *recipetype.Service
	ingredientService *recipeingredient.Service
	stepsService      *recipestep.Service
}

func NewService(repo *Repository, recipeTypeService *recipetype.Service, ingredientService *recipeingredient.Service, stepsService *recipestep.Service) *Service {
	return &Service{
		repo:              repo,
		recipeTypeService: recipeTypeService,
		ingredientService: ingredientService,
		stepsService:      stepsService,
	}
}

func (s *Service) GetAll() ([]GetRecipeSimpleDTO, error) {
	list, err := (*s.repo).GetAll()
	if err != nil {
		return []GetRecipeSimpleDTO{}, err
	}
	return EntityListToDTO(list), nil
}

func (s *Service) GetByID(id string) (GetRecipeDTO, error) {
	recipe, err := (*s.repo).GetByID(id)
	if err != nil {
		return GetRecipeDTO{}, err
	}
	if recipe.ID == "" {
		return GetRecipeDTO{}, errors.New("recipe not found")
	}
	return EntityToDTO(recipe), nil
}

func (s *Service) Delete(id string) error {
	err := (*s.repo).Delete(id)
	return err
}

func (s *Service) Save(recipe CreateRecipeDTO) (types.IdDTO, error) {
	existsType, err := (*s.recipeTypeService).ExistsByID(recipe.Type.ID)
	if err != nil {
		return types.IdDTO{}, err
	}
	if !existsType {
		return types.IdDTO{}, errors.New("type does not exists")
	}

	if len(recipe.Ingredients) == 0 {
		return types.IdDTO{}, errors.New("ingredients is required")
	}
	if len(recipe.Steps) == 0 {
		return types.IdDTO{}, errors.New("steps is required")
	}

	recipeToCreate := CreateDTOToEntity(recipe)

	id, err := (*s.repo).Save(recipeToCreate)
	if err != nil {
		return types.IdDTO{}, err
	}

	for i, v := range recipe.Ingredients {
		v.RecipeID = id
		recipe.Ingredients[i] = v
	}

	err = (*s.ingredientService).SaveAll(recipe.Ingredients)
	if err != nil {
		return types.IdDTO{}, err
	}

	for i, v := range recipe.Steps {
		v.RecipeID = id
		recipe.Steps[i] = v
	}
	err = (*s.stepsService).SaveAll(recipe.Steps)
	if err != nil {
		return types.IdDTO{}, err
	}

	return types.IdDTO{ID: id}, nil
}

func (s *Service) Update(id string, recipe CreateRecipeDTO) (types.IdDTO, error) {
	entity, err := (*s.repo).GetByID(id)
	if err != nil {
		return types.IdDTO{}, err
	}
	if reflect.ValueOf(entity).IsZero() {
		return types.IdDTO{}, errors.New("recipe not found")
	}

	existsType, err := (*s.recipeTypeService).ExistsByID(recipe.Type.ID)
	if err != nil {
		return types.IdDTO{}, err
	}
	if !existsType {
		return types.IdDTO{}, errors.New("type does not exists")
	}

	if len(recipe.Ingredients) == 0 {
		return types.IdDTO{}, errors.New("ingredients is required")
	}
	if len(recipe.Steps) == 0 {
		return types.IdDTO{}, errors.New("steps is required")
	}

	recipeToCreate := CreateDTOToEntity(recipe)
	recipeToCreate.ID = id

	_, err = (*s.repo).Save(recipeToCreate)
	if err != nil {
		return types.IdDTO{}, err
	}

	err = (*s.ingredientService).DeleteByRecipe(id)
	if err != nil {
		return types.IdDTO{}, err
	}

	for i, v := range recipe.Ingredients {
		v.RecipeID = id
		recipe.Ingredients[i] = v
	}

	err = (*s.stepsService).DeleteByRecipe(id)
	if err != nil {
		return types.IdDTO{}, err
	}

	err = (*s.ingredientService).SaveAll(recipe.Ingredients)
	if err != nil {
		return types.IdDTO{}, err
	}

	for i, v := range recipe.Steps {
		v.RecipeID = id
		recipe.Steps[i] = v
	}
	err = (*s.stepsService).SaveAll(recipe.Steps)
	if err != nil {
		return types.IdDTO{}, err
	}

	return types.IdDTO{ID: id}, nil
}

func (s *Service) GetAllByType(retyId string) (GetAllByTypeDTO, error) {
	list, err := (*s.repo).GetAllByType(retyId)
	if err != nil {
		return GetAllByTypeDTO{}, err
	}

	reciType, err := (*s.recipeTypeService).GetByID(retyId)
	if err != nil {
		return GetAllByTypeDTO{}, err
	}

	return GetAllByTypeDTO{
		Type:    reciType,
		Recipes: list,
	}, nil
}
