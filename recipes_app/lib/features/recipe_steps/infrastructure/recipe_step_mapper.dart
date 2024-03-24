import 'package:recipes_app/features/recipe_steps/domain/entities/get_recipe_step.dart';

final class RecipeStepMapper {
  static GetRecipeStep getRecipeStepFromJson(Map<String, dynamic> json) =>
      GetRecipeStep(
        id: json['id'],
        description: json['description'],
        order: json['order'] ?? 0,
        time: json['time'] ?? 0,
      );
}
