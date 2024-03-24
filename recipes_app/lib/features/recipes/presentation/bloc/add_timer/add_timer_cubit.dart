import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_state.dart';

class AddTimerCubit extends Cubit<bool> {
  AddTimerCubit() : super(false);

  void toggle() => emit(!state);
}
