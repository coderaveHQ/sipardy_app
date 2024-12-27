import 'package:sipardy_app/core/utils/enums/game_category.dart';

/// A model for the root question details
class GameQuestion {

  /// The id of the question
  final String id;

  /// When this question was created
  final DateTime createdAt;

  /// When this question was last updated
  final DateTime updatedAt;

  /// The category of this question
  final GameCategory category;

  /// The points this question gives
  final int points;

  /// The plain text of the question
  final String question;

  /// The plain text of the answer
  final String answer;

  /// Default constructor
  const GameQuestion({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.points,
    required this.question,
    required this.answer
  });

  /// Factory method for converting from JSON
  factory GameQuestion.fromJson(Map<String, dynamic> json) {
    return GameQuestion(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      category: GameCategory.fromDbValue(json['category'] as String),
      points: json['points'] as int,
      question: json['question'] as String,
      answer: json['answer'] as String
    );
  }

  /// Copies all current properties with updated passed values 
  GameQuestion copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    GameCategory? category,
    int? points,
    String? question,
    String? answer
  }) {
    return GameQuestion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      points: points ?? this.points,
      question: question ?? this.question,
      answer: answer ?? this.answer
    );
  }
}