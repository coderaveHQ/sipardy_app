/// Model for a player
class GameRoomPlayer {

  /// The position of the player which kind of is the ID of the player inside a room
  final int position;

  /// The ID of the room
  final String roomId;

  /// When the player was created
  final DateTime createdAt;

  /// When the player was last updated
  final DateTime updatedAt;

  /// The name of the player
  final String name;

  /// The points the player has
  final int points;

  /// Wether its the players turn
  final bool hasTurn;

  /// Default constructor
  const GameRoomPlayer({
    required this.position,
    required this.roomId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.points,
    required this.hasTurn
  });

  /// Factory method for converting from JSON
  factory GameRoomPlayer.fromJson(Map<String, dynamic> json) {
    return GameRoomPlayer(
      position: json['position'] as int,
      roomId: json['room_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      name: json['name'] as String,
      points: json['points'] as int,
      hasTurn: json['has_turn'] as bool
    );
  }

  /// Copies all current properties with updated passed values 
  GameRoomPlayer copyWith({
    int? position,
    String? roomId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    int? points,
    bool? hasTurn
  }) {
    return GameRoomPlayer(
      position: position ?? this.position,
      roomId: roomId ?? this.roomId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      points: points ?? this.points,
      hasTurn: hasTurn ?? this.hasTurn
    );
  }
}