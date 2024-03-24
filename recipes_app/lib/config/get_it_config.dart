import 'package:get_it/get_it.dart';
import 'package:recipes_app/features/recipe_types/domain/domain.dart';
import 'package:recipes_app/features/recipe_types/infrastructure/recipe_type_datasource_impl.dart';
import 'package:recipes_app/features/recipe_types/infrastructure/recipe_type_repository.dart';
import 'package:recipes_app/features/recipes/domain/recipe_repository.dart';
import 'package:recipes_app/features/recipes/infrastructure/recipe_datasource_impl.dart';
import 'package:recipes_app/features/recipes/infrastructure/recipe_repository_impl.dart';
import 'package:recipes_app/features/shared/infrastructure/api_provider.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<RecipeTypeDatasource>(
    RecipeTypeDatasourceImpl(ApiProvider.dio),
  );

  getIt.registerSingleton<RecipeTypeRepository>(
    RecipeTypeRepositoryImpl(getIt<RecipeTypeDatasource>()),
  );

  final recipeDatasource = RecipeDatasourceImpl(ApiProvider.dio);
  getIt.registerSingleton<RecipeRepository>(
    RecipeRepositoryImpl(recipeDatasource),
  );
}
