import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:collection/collection.dart';

import 'package:sipardy_app/core/res/localization/language/custom_language_data.dart';

/// An enum holding all languages usable
enum CustomLanguageMode {

  /// Based on the system language
  system(
    id: null
  ),

  /// English
  en(
    id: 1
  ),

  /// German
  de(
    id: 2
  ),

  /// Italian
  it(
    id: 3
  );

  /// An ID for the value
  final int? id;

  /// Default constructor
  const CustomLanguageMode({
    this.id
  });

  /// Gets the language mode by ID
  static CustomLanguageMode getLanguageModeById(int? id) {
    return CustomLanguageMode.values.firstWhereOrNull((CustomLanguageMode mode) => mode.id == id) ?? CustomLanguageMode.system;
  }

  /// Gets the absolute language mode without the .system mode
  CustomLanguageMode get withoutSystem {
    if (this != CustomLanguageMode.system) return this;
    return _systemLanguageMode;
  }

  /// Gets the actual language data based on the enum value
  CustomLanguageData get languageData {
    return switch (this) {
      CustomLanguageMode.system => _systemLanguageMode.languageData,
      CustomLanguageMode.en => const CustomLanguageData.en(),
      CustomLanguageMode.de => const CustomLanguageData.de(),
      CustomLanguageMode.it => const CustomLanguageData.it()
    };
  }

  /// Gets the language mode based on the systems settings
  CustomLanguageMode get _systemLanguageMode {
    final Locale systemLocale = SchedulerBinding.instance.platformDispatcher.locale;
    return switch (systemLocale.languageCode) {
      'de' => CustomLanguageMode.de,
      'it' => CustomLanguageMode.it,
      _ => CustomLanguageMode.en
    };
  }

  /// Helper for displaying localizable text dynamically
  String chooseLanguage({
    required String en,
    required String de,
    required String it
  }) {
    return switch (this) {
      CustomLanguageMode.system => _systemLanguageMode.chooseLanguage(
        en: en, 
        de: de,
        it: it
      ),
      CustomLanguageMode.en => en,
      CustomLanguageMode.de => de,
      CustomLanguageMode.it => it
    };
  }
}