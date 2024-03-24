import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/features/recipe_ingredients/domain/entities/create_recipe_ingredient.dart';

part 'recipe_form_event.dart';
part 'recipe_form_state.dart';

class RecipeFormBloc extends Bloc<RecipeFormEvent, RecipeFormState> {
  RecipeFormBloc() : super(const RecipeFormState()) {
    on<AddIngredient>(onAddIngredient);
  }

  void onAddIngredient(AddIngredient event, Emitter emit) {
    final ingredients = [...state.ingredients, event.ingredient];
    emit(state.copyWith(ingredients: ingredients));
  }
}
