package recipetype

func EntityToDTO(entity RecipeType) RecipeTypeDTO {
	return RecipeTypeDTO{
		ID:   entity.ID,
		Name: entity.Name,
	}
}

func EntityListToDTO(list []RecipeType) []RecipeTypeDTO {
	dtoList := make([]RecipeTypeDTO, len(list))

	for i, v := range list {
		dtoList[i] = EntityToDTO(v)
	}

	return dtoList
}
