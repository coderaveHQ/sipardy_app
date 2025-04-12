import 'package:sipardy_app/core/error/i_error.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_mode.dart';

/// A class holding possible launch errors
class LaunchError extends IError {

  /// An error for when an URL could not be opened
  LaunchError.urlNotOpened()
    : super((CustomLanguageMode mode) => mode.chooseLanguage(
      en: 'URL could not be opened.', 
      de: 'URL konnte nicht geöffnet werden.'
    ));
}