part of 'timer_bloc.dart';

enum TimerStateEnum { running, stop, finished, pause }

class TimerState extends Equatable {
  const TimerState({
    required this.time,
    required this.totalTime,
    this.state = TimerStateEnum.stop,
  });

  final int time;
  final int totalTime;
  final TimerStateEnum state;

  TimerState copyWith({int? time, TimerStateEnum? state}) => TimerState(
        time: time ?? this.time,
        state: state ?? this.state,
        totalTime: totalTime,
      );

  String get timeTxt {
    if (time == 0) return '0m';

    int minutes = time ~/ 60;
    int remainingSeconds = time % 60;

    String formattedTime = '';
    if (minutes > 0) {
      formattedTime += '$minutes m ';
    }
    formattedTime += '$remainingSeconds s';

    return formattedTime;
  }

  @override
  List<Object> get props => [time, state];
}
