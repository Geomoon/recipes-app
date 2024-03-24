part of 'steps_bloc.dart';

sealed class StepsEvent extends Equatable {
  const StepsEvent();

  @override
  List<Object> get props => [];
}

final class ChangeCompletedEvent extends StepsEvent {
  final String id;
  final bool isCompleted;
  const ChangeCompletedEvent({required this.id, required this.isCompleted});
}

final class StartTimerEvent extends StepsEvent {
  final String id;
  const StartTimerEvent({required this.id});
}
