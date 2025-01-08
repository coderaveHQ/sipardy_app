import 'package:sipardy_app/core/error/i_error.dart';

/// A class holding possible game creation errors
class GameCreationError extends IError {

  /// An error for when no players were added
  const GameCreationError.noPlayersAdded()
    : super('Keine Spieler*innen hinzugefügt.');

  /// An error for when five categories are already picked
  const GameCreationError.alreadyFiveCategoriesPicked()
    : super('Maximal 5 Kategorien möglich.');

  /// An error for when less than five categories have been picked
  const GameCreationError.lessThanFiveCategoriesPicked()
    : super('Bitte 5 Kategorien wählen.');
}