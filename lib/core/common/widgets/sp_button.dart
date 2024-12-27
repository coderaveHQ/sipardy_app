import 'package:flutter/material.dart';

import 'package:sipardy_app/core/common/widgets/sp_circular_progress_indicator.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';

/// A custom button
class SPButton extends StatelessWidget {

  /// The onPressed callback
  final VoidCallback? onPressed;

  /// Indicates wether the button displays a loading indicator or a title
  final bool isLoading;

  /// Indicates wether the button is enabled
  final bool isEnabled;

  /// The title
  final String title;

  /// The background color
  final Color backgroundColor;

  /// The foreground color
  final Color foregroundColor;

  /// Default constructor
  const SPButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    required this.title,
    this.backgroundColor = SPColors.primaryButtonBackground,
    this.foregroundColor = SPColors.white
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: RawMaterialButton(
        onPressed: isEnabled ? onPressed : null,
        fillColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.symmetric(horizontal: SPSpacing.lg),
        enableFeedback: isEnabled,
        child: isLoading
          ? SPCircularProgressIndicator(
            color: foregroundColor,
            size: 18.0
          )
          : SPText(
            text: title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            alignment: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: foregroundColor
            )
          )
      )
    );
  }
}