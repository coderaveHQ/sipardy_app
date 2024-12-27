import 'package:flutter/material.dart';

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';

/// The type of toast
enum ToastType {

  /// Success
  success(
    icon: LucideIcons.check,
    iconColor: SPColors.green500
  ),
  /// Info
  info(
    icon: LucideIcons.info,
    iconColor: SPColors.blue500
  ),
  /// Warning
  warning(
    icon: LucideIcons.triangleAlert,
    iconColor: SPColors.orange500
  ),
  /// Error
  error(
    icon: LucideIcons.x,
    iconColor: SPColors.red500
  );

  /// The icon
  final IconData icon;

  /// The icon color
  final Color iconColor;

  /// Default constructor
  const ToastType({
    required this.icon,
    required this.iconColor
  });
}

/// A class for showing different types of toasts
class Toaster {

  /// Shows a success toast
  static void showSuccess(BuildContext context, String text) {
    _show(context, ToastType.success, text);
  }

  /// Shows an info toast
  static void showInfo(BuildContext context, String text) {
    _show(context, ToastType.info, text);
  }

  /// Shows a warning toast
  static void showWarning(BuildContext context, String text) {
    _show(context, ToastType.warning, text);
  }

  /// Shows an error toast
  static void showError(BuildContext context, String text) {
    _show(context, ToastType.error, text);
  }

  /// Shows a toast
  static void _show(BuildContext context, ToastType type, String text) {
    DelightToastBar(
      autoDismiss: true,
      builder: (BuildContext context) => _build(context, type, text)
    ).show(context);
  }

  /// Builds a toast
  static ToastCard _build(BuildContext context, ToastType type, String text) {
    return ToastCard(
      color: SPColors.secondaryBackground,
      leading: Icon(
        type.icon,
        size: 28.0,
        color: type.iconColor
      ),
      title: SPText(
        text: text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
          color: SPColors.white
        )
      )
    );
  }
}