import 'package:recipes_app/features/recipe_ingredients/domain/entities/get_recipe_ingredient.dart';

final class RecipeIngredientMapper {
  static GetRecipeIngredient getRecipeIngredientFromJson(
    Map<String, dynamic> json,
  ) =>
      GetRecipeIngredient(
        id: json['id'],
        description: json['description'],
        quantity: json['quantity'].toDouble(),
        quantityType: json['quantityType'],
      );
}
