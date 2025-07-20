import 'package:flutter/material.dart';

import 'package:sipardy_app/core/error/i_error.dart';
import 'package:sipardy_app/core/res/localization/custom_localization.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_mode.dart';
import 'package:sipardy_app/core/services/toaster.dart';

/// An extension class for Object
extension ObjectExtension on Object {

  /// Gets the message of the error if it is an error
  String getErrorMessage(BuildContext context) {
    final CustomLanguageMode languageMode = CustomLocalization.of(context).languageMode;
    if (this is IError) return (this as IError).message.call(languageMode);
    return languageMode.chooseLanguage(
      en: 'An unknown error occured.', 
      de: 'Ein unbekannter Fehler ist aufgetreten.',
      it: 'Si è verificato un errore sconosciuto.'
    );
  }

  /// Shows a toast with a proper message if its an error
  void showErrorToast(BuildContext context) {
    final String errorMessage = getErrorMessage(context);
    Toaster.showError(context, errorMessage);
  }
}