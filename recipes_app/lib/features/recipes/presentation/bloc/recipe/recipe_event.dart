part of 'recipe_bloc.dart';

sealed class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

final class LoadEvent extends RecipeEvent {
  final String id;
  const LoadEvent(this.id);
}
