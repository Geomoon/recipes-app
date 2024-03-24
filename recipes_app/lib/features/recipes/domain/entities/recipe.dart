import 'package:recipes_app/features/recipe_ingredients/domain/entities/get_recipe_ingredient.dart';
import 'package:recipes_app/features/recipe_steps/domain/entities/get_recipe_step.dart';
import 'package:recipes_app/features/recipe_types/domain/entities/get_recipe_type_model.dart';

class Recipe {
  String? id;
  String? name;
  String? img;
  int? numPortions;
  int time;
  DateTime? createdAt;
  GetRecipeTypeModel? type;
  List<GetRecipeIngredient> ingredients;
  List<GetRecipeStep> steps;

  Recipe({
    this.id,
    this.name,
    this.img,
    this.numPortions,
    this.time = 0,
    this.createdAt,
    this.type,
    this.ingredients = const [],
    this.steps = const [],
  });

  String get timeTxt {
    if (time == 0) return '0m';

    int minutes = time ~/ 60;
    int remainingSeconds = time % 60;

    String formattedTime = '';
    if (minutes > 0) {
      formattedTime += '$minutes m ';
    }
    formattedTime += '$remainingSeconds s';

    return formattedTime;
  }
}
