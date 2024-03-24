import 'package:recipes_app/features/recipe_types/domain/entities/entities.dart';

class RecipesByType {
  GetRecipeTypeModel type;
  List<RecipeByType> recipes;

  RecipesByType({
    required this.type,
    required this.recipes,
  });
}

class RecipeByType {
  String id;
  String name;
  String? img;
  int numPortions;
  DateTime? createdAt;
  int time;

  RecipeByType({
    required this.id,
    required this.name,
    this.createdAt,
    this.img,
    this.numPortions = 0,
    this.time = 0,
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
