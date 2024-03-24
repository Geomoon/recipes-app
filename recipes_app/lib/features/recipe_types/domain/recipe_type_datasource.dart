import 'package:recipes_app/features/recipe_types/domain/entities/entities.dart';

abstract class RecipeTypeDatasource {
  Future<List<GetRecipeTypeModel>> getAll();
}
