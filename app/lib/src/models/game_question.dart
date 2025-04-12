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

  /// The plain text of the question in german
  final String questionDe;

  /// The plain text of the answer in german
  final String answerDe;

  /// The plain text of the question in english
  final String questionEn;

  /// The plain text of the answer in english
  final String answerEn;

  /// Default constructor
  const GameQuestion({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.points,
    required this.questionDe,
    required this.answerDe,
    required this.questionEn,
    required this.answerEn
  });

  /// Factory method for converting from JSON
  factory GameQuestion.fromJson(Map<String, dynamic> json) {
    return GameQuestion(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      category: GameCategory.fromDbValue(json['category'] as String),
      points: json['points'] as int,
      questionDe: json['question_de'] as String,
      answerDe: json['answer_de'] as String,
      questionEn: json['question_en'] as String,
      answerEn: json['answer_en'] as String
    );
  }

  /// Copies all current properties with updated passed values 
  GameQuestion copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    GameCategory? category,
    int? points,
    String? questionDe,
    String? answerDe,
    String? questionEn,
    String? answerEn
  }) {
    return GameQuestion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      points: points ?? this.points,
      questionDe: questionDe ?? this.questionDe,
      answerDe: answerDe ?? this.answerDe,
      questionEn: questionEn ?? this.questionEn,
      answerEn: answerEn ?? this.answerEn
    );
  }
}