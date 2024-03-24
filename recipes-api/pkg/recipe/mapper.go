package recipe

import (
	"log"
	recipeingredient "recipes-api/pkg/recipe_ingredient"
	recipestep "recipes-api/pkg/recipe_step"
	recipetype "recipes-api/pkg/recipe_type"
)

func EntityToDTO(entity Recipe) GetRecipeDTO {
	log.Println(entity)
	dto := GetRecipeDTO{
		ID:          entity.ID,
		Name:        entity.Name,
		Img:         entity.Img,
		Time:        entity.Time,
		NumPortions: entity.NumPortions,
		CreatedAt:   entity.CreatedAt,
	}

	if entity.Type.ID != "" {
		dto.Type = recipetype.RecipeTypeDTO{
			ID:   entity.Type.ID,
			Name: entity.Type.Name,
		}
	}

	dto.Ingredients = recipeingredient.EntityListToDTO(entity.Ingredients)
	dto.Steps = recipestep.EntityListToDTO(entity.Steps)

	return dto
}

func EntityToSimpleDTO(entity Recipe) GetRecipeSimpleDTO {
	log.Println(entity)
	dto := GetRecipeSimpleDTO{
		ID:          entity.ID,
		Name:        entity.Name,
		Img:         entity.Img,
		NumPortions: entity.NumPortions,
		CreatedAt:   entity.CreatedAt,
	}

	if entity.Type.ID != "" {
		dto.Type = recipetype.RecipeTypeDTO{
			ID:   entity.Type.ID,
			Name: entity.Type.Name,
		}
	}
	return dto
}

func EntityListToDTO(list []Recipe) []GetRecipeSimpleDTO {
	listDto := make([]GetRecipeSimpleDTO, len(list))
	for i, v := range list {
		listDto[i] = EntityToSimpleDTO(v)
	}
	return listDto
}

func CreateDTOToEntity(dto CreateRecipeDTO) Recipe {
	entity := Recipe{
		Name:        dto.Name,
		NumPortions: dto.NumPortions,
		Img:         dto.Img,
		RetyID:      dto.Type.ID,
	}

	return entity
}
