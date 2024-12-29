import 'package:flutter/material.dart';

import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/res/theme/typography/sp_typography.dart';

/// A custom TextField
class SPTextField extends StatelessWidget {

  /// The controller
  final TextEditingController? controller;

  /// The input type
  final TextInputType? inputType;

  /// The icon
  final IconData? icon;

  /// The hint
  final String? hint;

  /// Whether the text is obscured
  final bool obscure;

  /// Whether the text field is enabled
  final bool isEnabled;

  /// Default constructor
  const SPTextField({
    super.key,
    this.controller,
    this.inputType = TextInputType.text,
    this.icon,
    this.hint,
    this.obscure = false,
    this.isEnabled = true
  });

  @override
  Widget build(BuildContext context) {

    final OutlineInputBorder noBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: SPColors.gray400, 
        width: 1.5
      )
    );

    return TextField(
      keyboardAppearance: Brightness.dark,
      controller: controller,
      autocorrect: false,
      enabled: isEnabled,
      keyboardType: inputType,
      canRequestFocus: isEnabled,
      obscureText: obscure,
      cursorColor: SPColors.gray400,
      style: SPTypography.base.copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: SPColors.white
      ),
      decoration: InputDecoration(
        fillColor: SPColors.secondaryBackground,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: SPSpacing.md,
          vertical: (52.0 - (icon != null ? 24.0 : 16.0)) / 2.0
        ),
        border: noBorder,
        errorBorder: noBorder,
        enabledBorder: noBorder,
        disabledBorder: noBorder,
        focusedErrorBorder: noBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: SPColors.primaryButtonBackground, 
            width: 2.0
          )
        ),
        prefixIconConstraints: const BoxConstraints.tightFor(height: 24.0),
        prefixIcon: icon != null
          ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: SPSpacing.md),
            child: Icon(
              icon,
              color: SPColors.white
            )
          )
          : null,
        hintText: hint,
        hintStyle: SPTypography.base.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: SPColors.gray400
        )
      )
    );
  }
}