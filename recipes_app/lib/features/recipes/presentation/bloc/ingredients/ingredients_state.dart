part of 'ingredients_bloc.dart';

class IngredientsState extends Equatable {
  const IngredientsState({
    required this.ingredients,
    this.isLoading = false,
  });

  final List<GetRecipeIngredient> ingredients;
  final bool isLoading;

  IngredientsState copyWith({
    List<GetRecipeIngredient>? ingredients,
    bool? isLoading,
  }) =>
      IngredientsState(
        ingredients: ingredients ?? this.ingredients,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object> get props => [ingredients, isLoading];
}
