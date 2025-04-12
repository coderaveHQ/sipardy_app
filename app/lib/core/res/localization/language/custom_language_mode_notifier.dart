import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:sipardy_app/core/res/localization/language/custom_language_mode.dart';
import 'package:sipardy_app/core/services/preferences.dart';

part 'custom_language_mode_notifier.g.dart';

/// A notifier for the language mode
@riverpod
class CustomLanguageModeNotifier extends _$CustomLanguageModeNotifier {

  late Preferences _preferences;

  @override
  CustomLanguageMode build() {
    _preferences = ref.watch(preferencesProvider);
    return _preferences.getCustomLanguageMode();
  }

  /// Sets the current state and updated the local preferences
  Future<void> setLanguageMode(CustomLanguageMode languageMode) async {
    state = languageMode;
    await _preferences.setCustomLanguageMode(languageMode);
  }
}