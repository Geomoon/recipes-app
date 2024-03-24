import 'package:recipes_app/features/recipe_types/domain/domain.dart';
import 'package:recipes_app/features/recipe_types/domain/entities/get_recipe_type_model.dart';

class RecipeTypeRepositoryImpl implements RecipeTypeRepository {
  final RecipeTypeDatasource _datasource;

  RecipeTypeRepositoryImpl(this._datasource);

  @override
  Future<List<GetRecipeTypeModel>> getAll() => _datasource.getAll();
}
