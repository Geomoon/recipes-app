part of 'recipe_form_bloc.dart';

sealed class RecipeFormEvent extends Equatable {
  const RecipeFormEvent();

  @override
  List<Object> get props => [];
}

class AddIngredient extends RecipeFormEvent {
  const AddIngredient(this.ingredient);

  final CreateRecipeIngredient ingredient;

  @override
  List<Object> get props => [ingredient];
}

class RemoveIngredient extends RecipeFormEvent {
  const RemoveIngredient(this.index);
  final int index;
}
