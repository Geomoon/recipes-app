part of 'recipe_ingredient_form_bloc.dart';

sealed class RecipeIngredientFormEvent extends Equatable {
  const RecipeIngredientFormEvent();

  @override
  List<Object> get props => [];
}

final class ChangeIngredientInput extends RecipeIngredientFormEvent {
  const ChangeIngredientInput(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

final class ChangeQuantityInput extends RecipeIngredientFormEvent {
  const ChangeQuantityInput(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

final class ChangeQuantityTypeInput extends RecipeIngredientFormEvent {
  const ChangeQuantityTypeInput(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

final class Submit extends RecipeIngredientFormEvent {
  const Submit();
}

final class Reset extends RecipeIngredientFormEvent {
  const Reset();
}
