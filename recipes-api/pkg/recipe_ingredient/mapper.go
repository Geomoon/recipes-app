package recipeingredient

func CreateDTOToEntity(dto CreateIngredientDTO) RecipeIngredient {
	return RecipeIngredient{
		Description:  dto.Description,
		Quantity:     dto.Quantity,
		QuantityType: dto.QuantityType,
		RecipeID:     dto.RecipeID,
	}
}

func CreateDTOListToEntity(list []CreateIngredientDTO) []RecipeIngredient {
	ingredients := make([]RecipeIngredient, len(list))

	for i, v := range list {
		ingredients[i] = CreateDTOToEntity(v)
	}
	return ingredients
}

func EntityToDTO(entity RecipeIngredient) RecipeIngredientDTO {
	return RecipeIngredientDTO{
		ID:           entity.ID,
		Description:  entity.Description,
		Quantity:     entity.Quantity,
		QuantityType: entity.QuantityType,
	}
}

func EntityListToDTO(entities []RecipeIngredient) []RecipeIngredientDTO {
	if len(entities) == 0 {
		return []RecipeIngredientDTO{}
	}
	list := make([]RecipeIngredientDTO, len(entities))
	for i, v := range entities {
		list[i] = EntityToDTO(v)
	}
	return list
}
