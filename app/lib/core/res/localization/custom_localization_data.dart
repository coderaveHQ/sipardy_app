import 'package:sipardy_app/core/res/localization/language/custom_language_data.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_mode.dart';

/// A class holding data about localization
class CustomLocalizationData {

  /// The language mode to use
  final CustomLanguageMode languageMode;

  /// Default constructor
  const CustomLocalizationData({
    required this.languageMode
  });

  /// The actual localized data of the language mode
  CustomLanguageData get language => languageMode.languageData;

  /// Helper for displaying localizable text dynamically
  String chooseLanguage({
    required String en,
    required String de,
    required String it
  }) => languageMode.chooseLanguage(
    en: en, 
    de: de,
    it: it
  );
}