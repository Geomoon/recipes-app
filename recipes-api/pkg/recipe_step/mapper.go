package recipestep

func CreateDTOToEntity(dto CreateStepDTO) RecipeStep {
	return RecipeStep{
		Description: dto.Description,
		Time:        dto.Time,
		Order:       dto.Order,
		RecipeID:    dto.RecipeID,
	}
}

func CreateDTOListToEntity(list []CreateStepDTO) []RecipeStep {
	entities := make([]RecipeStep, len(list))
	for i, v := range list {
		entities[i] = CreateDTOToEntity(v)
	}
	return entities
}

func EntityToDTO(step RecipeStep) GetStepDTO {
	return GetStepDTO{
		ID:          step.ID,
		Description: step.Description,
		Order:       step.Order,
		Time:        step.Time,
	}
}

func EntityListToDTO(entities []RecipeStep) []GetStepDTO {
	if len(entities) == 0 {
		return []GetStepDTO{}
	}
	list := make([]GetStepDTO, len(entities))
	for i, v := range entities {
		list[i] = EntityToDTO(v)
	}
	return list
}
