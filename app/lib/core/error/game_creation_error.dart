import 'package:sipardy_app/core/error/i_error.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_mode.dart';

/// A class holding possible game creation errors
class GameCreationError extends IError {

  /// An error for when no players were added
  GameCreationError.noPlayersAdded()
    : super((CustomLanguageMode mode) => mode.chooseLanguage(
      en: 'No players added.', 
      de: 'Keine Spieler*innen hinzugefügt.'
    ));

  /// An error for when five categories are already picked
  GameCreationError.alreadyFiveCategoriesPicked()
    : super((CustomLanguageMode mode) => mode.chooseLanguage(
      en: 'Maximum of 5 categories possible.', 
      de: 'Maximal 5 Kategorien möglich.'
    ));

  /// An error for when less than five categories have been picked
  GameCreationError.lessThanFiveCategoriesPicked()
    : super((CustomLanguageMode mode) => mode.chooseLanguage(
      en: 'Please select 5 categories.', 
      de: 'Bitte 5 Kategorien wählen.'
    ));
}