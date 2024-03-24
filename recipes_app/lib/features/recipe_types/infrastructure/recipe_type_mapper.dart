import 'package:recipes_app/features/recipe_types/domain/entities/entities.dart';

class RecipeTypeMapper {
  static GetRecipeTypeModel fromJson(Map<String, dynamic> json) =>
      GetRecipeTypeModel(id: json['id'], name: json['name']);
}
