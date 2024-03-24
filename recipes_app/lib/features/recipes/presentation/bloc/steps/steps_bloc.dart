import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/features/recipe_steps/domain/entities/get_recipe_step.dart';

part 'steps_event.dart';
part 'steps_state.dart';

class StepsBloc extends Bloc<StepsEvent, StepsState> {
  StepsBloc(List<GetRecipeStep> steps) : super(StepsState(steps)) {
    on<ChangeCompletedEvent>(_onChangeCompletedEvent);
  }

  void changeCompleted(String id, bool isCompleted) =>
      add(ChangeCompletedEvent(id: id, isCompleted: isCompleted));

  void _onChangeCompletedEvent(
    ChangeCompletedEvent event,
    Emitter<StepsState> emit,
  ) {
    final list = state.steps.map((e) {
      if (e.id == event.id) {
        e = e.copyWith(isComplete: event.isCompleted);
      }
      return e;
    }).toList();

    emit(state.copyWith(steps: list));
  }
}
