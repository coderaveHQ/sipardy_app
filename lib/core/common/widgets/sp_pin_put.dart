import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';

import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/typography/sp_typography.dart';

/// A custom PinPut
class SPPinPut extends StatelessWidget {

  /// The controller
  final TextEditingController? controller;

  /// Whether the pin put is enabled
  final bool enabled;

  /// The number of digits
  final int length;

  /// Callback for when all digits have been entered
  final void Function(String)? onCompleted;
  
  /// Default constructor
  const SPPinPut({ 
    super.key,
    this.controller,
    this.enabled = true,
    this.length = 4,
    this.onCompleted
  });

  @override
  Widget build(BuildContext context) {
    final PinTheme defaultPinTheme = PinTheme(
      width: 52.0,
      height: 52.0,
      textStyle: SPTypography.base.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        color: SPColors.white
      ),
      decoration: BoxDecoration(
        color: SPColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: null
      )
    );

    final PinTheme focusedPinTheme = defaultPinTheme.copyBorderWith(border: Border.all(
      color: SPColors.primaryButtonBackground,
      width: 1.5
    ));
    
    return Pinput(
      controller: controller,
      enabled: enabled,
      keyboardAppearance: Brightness.dark,
      length: length,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      autofocus: true,
      onCompleted: onCompleted
    );
  }
}