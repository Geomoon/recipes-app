import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_by_type.dart';
import 'package:recipes_app/features/recipes/domain/recipe_repository.dart';

part 'get_recipes_by_type_event.dart';
part 'get_recipes_by_type_state.dart';

class GetRecipesByTypeBloc
    extends Bloc<GetRecipesByTypeEvent, GetRecipesByTypeState> {
  GetRecipesByTypeBloc(this.repository) : super(GetRecipesByTypeInitial()) {
    on<GetRecipesByTypeIdEvent>(_onGetRecipesByTypeIdEvent);
  }

  final RecipeRepository repository;

  void exec(String typeId) => add(GetRecipesByTypeIdEvent(typeId));

  void _onGetRecipesByTypeIdEvent(
    GetRecipesByTypeIdEvent event,
    Emitter<GetRecipesByTypeState> emit,
  ) async {
    try {
      emit(GetRecipesByTypeLoading());
      final data = await repository.getAllByType(event.typeId);
      emit(GetRecipesByTypeLoaded(data));
    } catch (e) {
      emit(const GetRecipesByTypeError('Error loading recipes'));
    }
  }
}
