part of 'recipe_bloc.dart';

sealed class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

final class RecipeInitial extends RecipeState {}

final class RecipeLoading extends RecipeState {}

final class RecipeError extends RecipeState {
  final String message;

  const RecipeError(this.message);
}

final class RecipeReady extends RecipeState {
  final Recipe recipe;

  const RecipeReady(this.recipe);
}
