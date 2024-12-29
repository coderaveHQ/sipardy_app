import 'package:flutter/material.dart';

import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';

/// A custom chip
class SPChip extends StatelessWidget {

  /// The callback when the chip is pressed
  final VoidCallback? onPressed;

  /// The title
  final String title;

  /// Whether the chip is enabled
  final bool isEnabled;

  /// The background color of the chip
  final Color backgroundColor;

  /// The foreground color of the chip
  final Color foregroundColor;

  /// Default Constructor
  const SPChip.basic({
    super.key,
    required this.title,
    this.backgroundColor = SPColors.blue500,
    this.foregroundColor= SPColors.white
  })  : onPressed = null,
        isEnabled= false;

  /// Constructor for delete chips
  const SPChip.clickable({
    super.key,
    required this.title,
    this.onPressed,
    this.isEnabled = true,
    this.backgroundColor = SPColors.blue500,
    this.foregroundColor= SPColors.white
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: IntrinsicWidth(
        child: RawMaterialButton(
          onPressed: isEnabled ? onPressed : null,
          enableFeedback: isEnabled,
          fillColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: SPSpacing.md),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Center(
            child: SPText(
              text: title,
              alignment: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: foregroundColor
              )
            )
          )
        )
      )
    );
  }
}