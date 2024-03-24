import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_by_type.dart';
import 'package:recipes_app/features/recipes/domain/recipe_datasource.dart';
import 'package:recipes_app/features/recipes/infrastructure/recipe_mapper.dart';

class RecipeDatasourceImpl implements RecipeDatasource {
  final Dio _dio;
  RecipeDatasourceImpl(this._dio);

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Recipe>> getAll() async {
    try {
      final response = await _dio.get('/recipes');
      final data = response.data as List;

      return data.map((e) => RecipeMapper.fromJson(e)).toList();
    } catch (e) {
      log('error getAll', error: e);
      rethrow;
    }
  }

  @override
  Future<Recipe> getById(String id) async {
    try {
      final response = await _dio.get('/recipes/$id');
      return RecipeMapper.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> save(Recipe recipe) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<RecipesByType> getAllByType(String typeId) async {
    try {
      final response = await _dio.get('/recipes/type/$typeId');
      final data = response.data;

      return RecipeMapper.recipesByTypeFromJson(data);
    } catch (e) {
      log('error getAllByType', error: e);
      rethrow;
    }
  }
}
