class SuggestionModel {
  final String id;
  final String description;

  SuggestionModel({
    required this.id,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'description': this.description,
    };
  }

  factory SuggestionModel.fromMap(Map<String, dynamic> map) {
    return SuggestionModel(
      id: "",
      description: map['description'] as String,
    );
  }

  SuggestionModel copyWith({
    String? id,
    String? description,
  }) {
    return SuggestionModel(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  // factory SuggestionModel.fromGoogleApi()


}
