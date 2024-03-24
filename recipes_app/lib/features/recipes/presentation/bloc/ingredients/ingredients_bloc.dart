import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/features/recipe_ingredients/domain/entities/get_recipe_ingredient.dart';

part 'ingredients_event.dart';
part 'ingredients_state.dart';

class IngredientsBloc extends Bloc<IngredientsEvent, IngredientsState> {
  IngredientsBloc(List<GetRecipeIngredient> ingredients)
      : super(IngredientsState(ingredients: ingredients, isLoading: false)) {
    on<ChangeCompletedEvent>(_onChangeCompletedEvent);
  }

  void _onChangeCompletedEvent(
    ChangeCompletedEvent event,
    Emitter<IngredientsState> emit,
  ) {
    final list = state.ingredients.map((i) {
      if (i.id == event.value.$1) {
        i = i.copyWith(isComplete: event.value.$2);
      }
      return i;
    });

    emit(state.copyWith(ingredients: list.toList()));
  }

  void changeCompleted(String id, bool value) =>
      add(ChangeCompletedEvent((id, value)));
}
