/// Game action enum
enum GameAction {
  
  /// Choose
  choose(
    dbValue: 'choose',
  ),

  /// Show question
  showQuestion(
    dbValue: 'show_question',
  ),

  /// Show answer
  showAnswer(
    dbValue: 'show_answer',
  );

  /// Database value
  final String dbValue;

  /// Default constructor
  const GameAction({
    required this.dbValue,
  });

  /// Converts database value to an enum value
  static GameAction fromDbValue(String dbValue) {
    return GameAction.values.firstWhere(
      (GameAction action) => action.dbValue == dbValue,
      orElse: () => throw ArgumentError('Invalid dbValue: $dbValue')
    );
  }
}