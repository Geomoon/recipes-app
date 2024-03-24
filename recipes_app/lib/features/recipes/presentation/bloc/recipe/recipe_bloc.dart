import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe.dart';
import 'package:recipes_app/features/recipes/domain/recipe_repository.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeRepository repository;

  RecipeBloc({
    required this.repository,
  }) : super(RecipeInitial()) {
    on<LoadEvent>(_onLoadEvent);
  }

  void _onLoadEvent(LoadEvent event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());

    try {
      final data = await repository.getById(event.id);
      emit(RecipeReady(data));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }

  void loadRecipe(String id) {
    add(LoadEvent(id));
  }
}
