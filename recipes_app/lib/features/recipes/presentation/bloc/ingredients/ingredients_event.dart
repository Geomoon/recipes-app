part of 'ingredients_bloc.dart';

sealed class IngredientsEvent extends Equatable {
  const IngredientsEvent();

  @override
  List<Object> get props => [];
}

final class ChangeCompletedEvent extends IngredientsEvent {
  final (String id, bool value) value;
  const ChangeCompletedEvent(this.value);
}
