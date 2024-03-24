import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipes_app/features/recipe_ingredients/domain/entities/create_recipe_ingredient.dart';
import 'package:recipes_app/features/shared/presentation/inputs/inputs.dart';

part 'recipe_ingredient_form_event.dart';
part 'recipe_ingredient_form_state.dart';

class RecipeIngredientFormBloc
    extends Bloc<RecipeIngredientFormEvent, RecipeIngredientFormState> {
  RecipeIngredientFormBloc({
    required this.onSuccess,
  }) : super(const RecipeIngredientFormState()) {
    on<ChangeIngredientInput>(_onChangeIngredientInput);
    on<ChangeQuantityInput>(_onChangeQuantityInput);
    on<ChangeQuantityTypeInput>(_onChangeQuantityTypeInput);
    on<Submit>(_onSubmit);
    on<Reset>(_onReset);
  }

  final void Function(CreateRecipeIngredient) onSuccess;

  void _onChangeIngredientInput(
    ChangeIngredientInput event,
    Emitter<RecipeIngredientFormState> emit,
  ) {
    final ingredient = TextInput.dirty(event.value);

    emit(state.copyWith(
      ingredient: ingredient,
      isValid: Formz.validate([ingredient, state.quantity, state.quantityType]),
    ));
  }

  void _onChangeQuantityInput(
    ChangeQuantityInput event,
    Emitter<RecipeIngredientFormState> emit,
  ) {
    final value = double.tryParse(event.value);
    if (value == null) return;
    final quantity = NumericInput.dirty(value: value);

    emit(state.copyWith(
      quantity: quantity,
      isValid: Formz.validate([quantity, state.ingredient, state.quantityType]),
    ));
  }

  void _onChangeQuantityTypeInput(
    ChangeQuantityTypeInput event,
    Emitter emit,
  ) {
    final type = TextInput.dirty(event.value);

    emit(state.copyWith(
      quantityType: type,
      isValid: Formz.validate([type, state.ingredient, state.quantity]),
    ));
  }

  void _onSubmit(Submit event, Emitter emit) {
    final isValid = Formz.validate(
      [state.ingredient, state.quantity, state.quantityType],
    );
    if (!isValid) {
      emit(state.copyWith(isValid: isValid));
      return;
    }

    final ingredient = CreateRecipeIngredient(
      description: state.ingredient.value,
      quantity: state.quantity.value,
      quantityType: state.quantityType.value,
    );

    onSuccess(ingredient);

    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }

  void _onReset(Reset event, Emitter emit) {
    emit(const RecipeIngredientFormState());
  }
}
