import 'package:flutter/material.dart';

import 'package:sipardy_app/core/common/widgets/sp_circular_progress_indicator.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';

/// A custom square button
class SPSquareButton extends StatelessWidget {

  /// The onPressed callback
  final VoidCallback? onPressed;

  /// Indicates wether the button displays a loading indicator or a title
  final bool isLoading;

  /// Indicates wether the button is enabled
  final bool isEnabled;

  /// The icon
  final IconData icon;

  /// The background color
  final Color backgroundColor;

  /// The foreground color
  final Color foregroundColor;

  /// The size
  final double size;

  /// The border radius
  final double borderRadius;

  /// Default constructor
  const SPSquareButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    required this.icon,
    this.backgroundColor = SPColors.primaryButtonBackground,
    this.foregroundColor = SPColors.white,
    this.size = 52.0,
    this.borderRadius = 12.0
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: RawMaterialButton(
        onPressed: isEnabled ? onPressed : null,
        fillColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        enableFeedback: isEnabled,
        child: isLoading
          ? SPCircularProgressIndicator(
            color: foregroundColor,
            size: 24.0
          )
          : Icon(
            icon,
            size: 24.0,
            color: foregroundColor
          )
      )
    );
  }
}