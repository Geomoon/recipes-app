import 'package:recipes_app/features/recipe_ingredients/domain/entities/create_recipe_ingredient.dart';
import 'package:recipes_app/features/recipe_steps/domain/entities/create_recipe_step.dart';
import 'package:recipes_app/features/recipe_types/domain/entities/get_recipe_type_model.dart';

class CreateRecipe {
  final String name;
  final int numPortions;
  final String img;
  final GetRecipeTypeModel type;
  final List<CreateRecipeIngredient> ingredients;
  final List<CreateRecipeStep> steps;

  CreateRecipe({
    required this.name,
    required this.numPortions,
    required this.img,
    required this.type,
    required this.ingredients,
    required this.steps,
  });
}
