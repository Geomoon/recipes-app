import 'package:recipes_app/features/recipes/domain/entities/recipe.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_by_type.dart';
import 'package:recipes_app/features/recipes/domain/recipe_datasource.dart';
import 'package:recipes_app/features/recipes/domain/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeDatasource _datasource;
  RecipeRepositoryImpl(this._datasource);
  @override
  Future<bool> delete(String id) {
    return _datasource.delete(id);
  }

  @override
  Future<List<Recipe>> getAll() {
    return _datasource.getAll();
  }

  @override
  Future<Recipe> getById(String id) {
    return _datasource.getById(id);
  }

  @override
  Future<String> save(Recipe recipe) {
    return _datasource.save(recipe);
  }

  @override
  Future<RecipesByType> getAllByType(String typeId) {
    return _datasource.getAllByType(typeId);
  }
}
