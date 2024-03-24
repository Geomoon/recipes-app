import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe.dart';
import 'package:recipes_app/features/recipes/domain/recipe_repository.dart';

part 'get_recipes_state.dart';

class GetRecipesCubit extends Cubit<GetRecipesState> {
  GetRecipesCubit(this.repository) : super(const GetRecipesInitial([])) {
    _loadItems();
  }

  final RecipeRepository repository;

  void _loadItems() async {
    final items = await repository.getAll();
    emit(GetRecipesInitial(items));
  }
}
