class GetRecipeStep {
  String id;
  String description;
  int order;
  int time;
  bool isComplete;

  GetRecipeStep({
    required this.id,
    required this.description,
    required this.order,
    required this.time,
    this.isComplete = false,
  });

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

  GetRecipeStep copyWith({
    String? id,
    String? description,
    int? order,
    int? time,
    bool? isComplete,
  }) =>
      GetRecipeStep(
        id: id ?? this.id,
        description: description ?? this.description,
        order: order ?? this.order,
        time: time ?? this.time,
        isComplete: isComplete ?? this.isComplete,
      );
}
