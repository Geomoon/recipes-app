import 'package:recipes_app/features/recipes/domain/entities/recipe.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_by_type.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getAll();
  Future<RecipesByType> getAllByType(String typeId);
  Future<Recipe> getById(String id);
  Future<String> save(Recipe recipe);
  Future<bool> delete(String id);
}
