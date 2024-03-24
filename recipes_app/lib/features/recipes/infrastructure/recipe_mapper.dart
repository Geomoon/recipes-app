import 'package:recipes_app/features/recipe_ingredients/infrastructure/recipe_ingredien_mapper.dart';
import 'package:recipes_app/features/recipe_steps/infrastructure/recipe_step_mapper.dart';
import 'package:recipes_app/features/recipe_types/infrastructure/recipe_type_mapper.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_by_type.dart';

class RecipeMapper {
  static Recipe fromJson(Map<String, dynamic> json) => Recipe(
        id: json['id'],
        name: json['name'],
        img: json['img'],
        time: json['time'] ?? 0,
        numPortions: json['numPortions'],
        createdAt: DateTime.tryParse(json['createdAt']),
        type: RecipeTypeMapper.fromJson(json['type']),
        ingredients: json['ingredients'] == null
            ? []
            : (json['ingredients'] as List)
                .map((e) =>
                    RecipeIngredientMapper.getRecipeIngredientFromJson(e))
                .toList(),
        steps: json['steps'] == null
            ? []
            : (json['steps'] as List)
                .map((e) => RecipeStepMapper.getRecipeStepFromJson(e))
                .toList(),
      );

  static RecipeByType recipeByTypeFromJson(Map<String, dynamic> json) =>
      RecipeByType(
        id: json['id'],
        name: json['name'],
        img: json['img'],
        numPortions: json['numPortions'],
        time: json['time'],
        createdAt: DateTime.tryParse(json['createdAt']),
      );

  static RecipesByType recipesByTypeFromJson(Map<String, dynamic> json) {
    final type = RecipeTypeMapper.fromJson(json['type']);
    final recipes =
        (json['recipes'] as List).map((e) => recipeByTypeFromJson(e)).toList();

    return RecipesByType(type: type, recipes: recipes);
  }
}
