import 'package:dio/dio.dart';
import 'package:recipes_app/features/recipe_types/domain/domain.dart';
import 'package:recipes_app/features/recipe_types/domain/entities/entities.dart';
import 'package:recipes_app/features/recipe_types/infrastructure/recipe_type_mapper.dart';

class RecipeTypeDatasourceImpl implements RecipeTypeDatasource {
  final Dio _dio;

  RecipeTypeDatasourceImpl(this._dio);

  @override
  Future<List<GetRecipeTypeModel>> getAll() async {
    try {
      final response = await _dio.get('/recipe-types');
      return (response.data as List)
          .map((e) => RecipeTypeMapper.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
