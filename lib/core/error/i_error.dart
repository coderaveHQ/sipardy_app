import 'package:flutter/material.dart';

import 'package:sipardy_app/core/services/toaster.dart';

/// An abstract class for errors
abstract class IError implements Exception {
  
  /// The message
  final String message;

  /// Default constructor
  const IError(this.message);

  /// Shows an error toast
  void showToast(BuildContext context) {
    Toaster.showError(context, message);
  }
}