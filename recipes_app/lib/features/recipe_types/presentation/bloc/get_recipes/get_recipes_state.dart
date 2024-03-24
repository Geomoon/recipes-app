part of 'get_recipe_types_cubit.dart';

sealed class GetRecipesState extends Equatable {
  const GetRecipesState(this.items);
  final List<GetRecipeTypeModel> items;

  @override
  List<Object> get props => [];
}

final class GetRecipesInitial extends GetRecipesState {
  const GetRecipesInitial(super.items);
}

final class GetRecipesLoading extends GetRecipesState {
  const GetRecipesLoading(super.items);
}

final class GetRecipesLoaded extends GetRecipesState {
  const GetRecipesLoaded(super.items);

  @override
  List<Object> get props => [items];
}
