import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sipardy_app/core/res/localization/language/custom_language_mode.dart';

part 'preferences.g.dart';

/// A provider for the custom preferences
@riverpod
Preferences preferences(Ref ref) {
  throw UnimplementedError();
}

/// A class for holding custom preferences
class Preferences {

  final SharedPreferences _sharedPreferences;

  /// Default constructor
  const Preferences({
    required SharedPreferences sharedPreferences
  }) : _sharedPreferences = sharedPreferences;

  static const String _languageModeKey = 'language-mode';

  /// Sets a language mode
  Future<void> setCustomLanguageMode(CustomLanguageMode mode) async {
    if (mode == CustomLanguageMode.system) {
      await removeCustomLanguageMode();
    } else {
      await _sharedPreferences.setInt(_languageModeKey, mode.id!);
    }
  }

  /// Gets the stored language mode
  CustomLanguageMode getCustomLanguageMode() {
    final int? languageModeId = _sharedPreferences.getInt(_languageModeKey);
    return CustomLanguageMode.getLanguageModeById(languageModeId);
  }

  /// Removes the language mode from the local preferences
  Future<void> removeCustomLanguageMode() async {
    await _sharedPreferences.remove(_languageModeKey);
  }
}