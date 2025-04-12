import 'package:flutter/material.dart';

import 'package:sipardy_app/core/res/localization/custom_localization.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_mode.dart';
import 'package:sipardy_app/core/services/toaster.dart';

/// An abstract class for errors
abstract class IError implements Exception {
  
  /// The message
  final String Function(CustomLanguageMode) message;

  /// Default constructor
  const IError(this.message);

  /// Shows an error toast
  void showToast(BuildContext context) {
    final CustomLanguageMode languageMode = CustomLocalization.of(context).languageMode;
    Toaster.showError(context, message.call(languageMode));
  }
}