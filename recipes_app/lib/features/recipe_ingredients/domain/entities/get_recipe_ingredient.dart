class GetRecipeIngredient {
  String id;
  String description;
  double? quantity;
  String? quantityType;
  bool isComplete;

  GetRecipeIngredient({
    required this.id,
    required this.description,
    this.quantity,
    this.quantityType,
    this.isComplete = false,
  });
  GetRecipeIngredient copyWith({
    String? id,
    String? description,
    double? quantity,
    String? quantityType,
    bool? isComplete,
  }) =>
      GetRecipeIngredient(
        id: id ?? this.id,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        quantityType: quantityType ?? this.quantityType,
        isComplete: isComplete ?? this.isComplete,
      );
}
