import 'package:flutter/material.dart';

import 'package:sipardy_app/core/common/widgets/sp_square_button.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';

/// A custom circular button
class SPCircularButton extends StatelessWidget {

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

  /// Default constructor
  const SPCircularButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    required this.icon,
    this.backgroundColor = SPColors.gray300,
    this.foregroundColor = SPColors.gray900,
    this.size = 52.0
  });

  @override
  Widget build(BuildContext context) {
    return SPSquareButton(
      onPressed: onPressed,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: icon,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      size: size,
      borderRadius: size / 2.0
    );
  }
}