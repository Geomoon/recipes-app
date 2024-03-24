part of 'timer_bloc.dart';

sealed class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

final class StartEvent extends TimerEvent {}

final class StopEvent extends TimerEvent {}

final class PauseEvent extends TimerEvent {}

final class FinishEvent extends TimerEvent {}

final class DecreaseEvent extends TimerEvent {
  // final int actualTime;

  // const DecreaseEvent(this.actualTime);
}
