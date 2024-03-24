import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_app/features/recipe_types/domain/domain.dart';
import 'package:recipes_app/features/recipe_types/domain/entities/entities.dart';

part 'get_recipes_state.dart';

class GetRecipeTypesCubit extends Cubit<GetRecipesState> {
  GetRecipeTypesCubit({required this.repository})
      : super(const GetRecipesInitial([])) {
    load();
  }

  final RecipeTypeRepository repository;

  void load() async {
    emit(const GetRecipesLoading([]));
    final items = await repository.getAll();
    emit(GetRecipesLoaded(items));
  }
}
