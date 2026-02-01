class SuggestionModel {
  final String description;

  SuggestionModel({required this.description});

  Map<String, dynamic> toMap() {
    return {"description": description};
  }

  factory SuggestionModel.fromMap(Map<String, dynamic> map) {
    return SuggestionModel(
      description: map['description'] ?? '',
    );
  }
}
