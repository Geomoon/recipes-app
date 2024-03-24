part of 'get_recipes_by_type_bloc.dart';

sealed class GetRecipesByTypeEvent extends Equatable {
  const GetRecipesByTypeEvent();

  @override
  List<Object> get props => [];
}

class GetRecipesByTypeIdEvent extends GetRecipesByTypeEvent {
  const GetRecipesByTypeIdEvent(this.typeId);

  final String typeId;
}
