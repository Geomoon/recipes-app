part of 'recipe_form_bloc.dart';

class RecipeFormState extends Equatable {
  const RecipeFormState({
    this.ingredients = const [],
  });

  final List<CreateRecipeIngredient> ingredients;

  RecipeFormState copyWith({
    List<CreateRecipeIngredient>? ingredients,
  }) =>
      RecipeFormState(
        ingredients: ingredients ?? this.ingredients,
      );

  @override
  List<Object> get props => [ingredients];
}
