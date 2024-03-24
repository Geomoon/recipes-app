import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc(int time) : super(TimerState(time: time, totalTime: time)) {
    on<StartEvent>(_onStart);
    on<DecreaseEvent>(_onDecreaseEvent);
    on<FinishEvent>(_onFinishEvent);
    on<PauseEvent>(_onPauseEvent);
    on<StopEvent>(_onStopEvent);
  }

  void start() => add(StartEvent());
  void stop() => add(StopEvent());
  void pause() => add(PauseEvent());

  late Timer timer;

  void _onPauseEvent(PauseEvent event, Emitter<TimerState> emit) {
    if (timer.isActive) {
      timer.cancel();
      emit(state.copyWith(state: TimerStateEnum.pause));
    }
  }

  void _onStopEvent(StopEvent event, Emitter<TimerState> emit) {
    timer.cancel();
    emit(state.copyWith(state: TimerStateEnum.stop, time: state.totalTime));
  }

  Future<void> _onStart(StartEvent event, Emitter<TimerState> emit) async {
    if (state.state == TimerStateEnum.finished) {
      emit(state.copyWith(time: state.totalTime, state: TimerStateEnum.stop));
      return;
    }

    if (state.state == TimerStateEnum.running) {
      add(PauseEvent());
      return;
    }

    emit(state.copyWith(state: TimerStateEnum.running));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final count = state.time - 1;
      if (count == 0) {
        timer.cancel();
        add(FinishEvent());
      }
      add(DecreaseEvent());
    });

    // while (timer.isActive) {}

    // for (int i = state.time; i >= 0; i--) {
    //   await Future.delayed(const Duration(seconds: 1));
    //   emit(state.copyWith(time: i, state: TimerStateEnum.running));
    // }
    // emit(state.copyWith(state: TimerStateEnum.finished));

    //  Timer.periodic(Duration(seconds: 5), (timer) {print('¿AAAA');}).;
  }

  void _onFinishEvent(FinishEvent event, Emitter<TimerState> emit) {
    emit(state.copyWith(state: TimerStateEnum.finished));
  }

  void _onDecreaseEvent(DecreaseEvent event, Emitter<TimerState> emit) {
    emit(state.copyWith(time: state.time - 1));
  }
}
