part of 'steps_bloc.dart';

class StepsState extends Equatable {
  const StepsState(this.steps);

  final List<GetRecipeStep> steps;

  @override
  List<Object> get props => [steps];

  StepsState copyWith({List<GetRecipeStep>? steps}) =>
      StepsState(steps ?? this.steps);
}
