import 'package:sipardy_app/src/models/game_question.dart';

/// Model for the questions
class GameRoomQuestion {

  /// The ID of the room
  final String roomId;

  /// The ID of the question
  final String questionId;

  /// When the question was created
  final DateTime createdAt;

  /// When the question was last updated
  final DateTime updatedAt;

  /// Wether the question is currently selected
  final bool selected;

  /// Wether the answer to this question was correct
  final bool? answer;

  /// The position of the player that selected the question
  final int? playerPosition;

  /// The root details of this question
  final GameQuestion details;

  /// Default constructor
  const GameRoomQuestion({
    required this.roomId,
    required this.questionId,
    required this.createdAt,
    required this.updatedAt,
    required this.selected,
    this.answer,
    this.playerPosition,
    required this.details
  });

  /// Factory method for converting from JSON
  factory GameRoomQuestion.fromJson(Map<String, dynamic> json) {
    return GameRoomQuestion(
      roomId: json['room_id'] as String,
      questionId: json['question_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      selected: json['selected'] as bool,
      answer: json['answer'] as bool?,
      playerPosition: json['player_position'] as int?,
      details: GameQuestion.fromJson(Map<String, dynamic>.from(json['game_questions']))
    );
  }

  /// Copies all current properties with updated passed values 
  GameRoomQuestion copyWith({
    String? roomId,
    String? questionId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? selected,
    bool? answer,
    int? playerPosition,
    GameQuestion? details,
    bool removeAnswer = false,
    bool removePlayerPosition = false
  }) {
    return GameRoomQuestion(
      roomId: roomId ?? this.roomId,
      questionId: questionId ?? this.questionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      selected: selected ?? this.selected,
      answer: removeAnswer ? null : answer ?? this.answer,
      playerPosition: removePlayerPosition ? null : this.playerPosition,
      details: details ?? this.details
    );
  }
}