part of 'get_recipes_cubit.dart';

sealed class GetRecipesState extends Equatable {
  const GetRecipesState(this.items);

  final List<Recipe> items;

  @override
  List<Object> get props => [items];
}

final class GetRecipesInitial extends GetRecipesState {
  const GetRecipesInitial(super.items);
}
