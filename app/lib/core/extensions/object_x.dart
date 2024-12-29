import 'package:flutter/material.dart';

import 'package:sipardy_app/core/error/i_error.dart';
import 'package:sipardy_app/core/services/toaster.dart';

/// An extension class for Object
extension ObjectExtension on Object {

  /// Gets the message of the error if it is an error
  String get errorMessage {
    if (this is IError) return (this as IError).message;
    return 'Ein unbekannter Fehler ist aufgetreten.';
  }

  /// Shows a toast with a proper message if its an error
  void showErrorToast(BuildContext context) {
    Toaster.showError(context, errorMessage);
  }
}