part of 'recipe_ingredient_form_bloc.dart';

class RecipeIngredientFormState extends Equatable {
  const RecipeIngredientFormState({
    this.ingredient = const TextInput.pure(),
    this.quantity = const NumericInput.pure(),
    this.quantityType = const TextInput.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  final TextInput ingredient;
  final NumericInput quantity;
  final TextInput quantityType;
  final bool isValid;
  final FormzSubmissionStatus status;

  RecipeIngredientFormState copyWith({
    TextInput? ingredient,
    NumericInput? quantity,
    TextInput? quantityType,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) =>
      RecipeIngredientFormState(
        ingredient: ingredient ?? this.ingredient,
        quantity: quantity ?? this.quantity,
        quantityType: quantityType ?? this.quantityType,
        isValid: isValid ?? this.isValid,
        status: status ?? this.status,
      );

  @override
  List<Object> get props =>
      [ingredient, quantity, quantityType, isValid, status];
}
