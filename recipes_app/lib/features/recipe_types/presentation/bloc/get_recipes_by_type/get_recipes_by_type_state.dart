part of 'get_recipes_by_type_bloc.dart';

sealed class GetRecipesByTypeState extends Equatable {
  const GetRecipesByTypeState();

  @override
  List<Object> get props => [];
}

final class GetRecipesByTypeInitial extends GetRecipesByTypeState {}

final class GetRecipesByTypeLoading extends GetRecipesByTypeState {}

final class GetRecipesByTypeLoaded extends GetRecipesByTypeState {
  const GetRecipesByTypeLoaded(this.data);
  final RecipesByType data;
}

final class GetRecipesByTypeError extends GetRecipesByTypeState {
  const GetRecipesByTypeError(this.error);
  final String error;
}
