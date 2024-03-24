import 'package:recipes_app/features/recipe_types/domain/entities/entities.dart';

abstract class RecipeTypeRepository {
  Future<List<GetRecipeTypeModel>> getAll();
}
