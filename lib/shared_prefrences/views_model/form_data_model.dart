
class FormDataModel {
  final String tagline;
  final String title;
  final String description;
  final int score;
  final int totalVotes;

  FormDataModel({
    required this.tagline,
    required this.title,
    required this.description,
    required this.score,
    required this.totalVotes,
  });

  // Convert a FormDataModel object to a JSON Map
  Map<String, dynamic> toJson() => {
    'tagline': tagline,
    'title': title,
    'description': description,
    'score': score,
    'totalVotes': totalVotes,
  };

  // Create a FormDataModel object from a JSON Map
  factory FormDataModel.fromJson(Map<String, dynamic> json) => FormDataModel(
    tagline: json['tagline'] ?? '',
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    score: json['score'] ?? 0.0,
    totalVotes: json['totalVotes'] ?? 0,
  );
}
