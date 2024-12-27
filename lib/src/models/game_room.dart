import 'package:sipardy_app/core/utils/enums/game_action.dart';
import 'package:sipardy_app/src/models/game_room_player.dart';
import 'package:sipardy_app/src/models/game_room_question.dart';

/// Model for the Game Room
class GameRoom {

  /// The ID of the room
  final String id;

  /// When the room was created
  final DateTime createdAt;

  /// When the room was last updated
  final DateTime updatedAt;

  /// The currently needed action
  final GameAction currentAction;

  /// A list of all players
  final List<GameRoomPlayer> players;

  /// A list of all questions
  final List<GameRoomQuestion> questions;

  /// Default constructor
  const GameRoom({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.currentAction,
    required this.players,
    required this.questions
  });

  /// Factory method for converting from JSON
  factory GameRoom.fromJson(Map<String, dynamic> json) {
    return GameRoom(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      currentAction: GameAction.fromDbValue(json['current_action'] as String),
      players: List<Map<String, dynamic>>.from(json['players']).map((Map<String, dynamic> playerJson) => GameRoomPlayer.fromJson(playerJson)).toList(),
      questions: List<Map<String, dynamic>>.from(json['questions']).map((Map<String, dynamic> questionJson) => GameRoomQuestion.fromJson(questionJson)).toList()
    );
  }

  /// Copies all current properties with updated passed values 
  GameRoom copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    GameAction? currentAction,
    List<GameRoomPlayer>? players,
    List<GameRoomQuestion>? questions
  }) {
    return GameRoom(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      currentAction: currentAction ?? this.currentAction,
      players: players ?? this.players,
      questions: questions ?? this.questions
    );
  }

  /// Gets the player whose turn it is
  GameRoomPlayer get playerTurn => players.firstWhere((GameRoomPlayer player) => player.hasTurn);

  /// Gets the currently selected question if there is one
  GameRoomQuestion? get selectedQuestion => questions.where((GameRoomQuestion question) => question.selected).firstOrNull;
}