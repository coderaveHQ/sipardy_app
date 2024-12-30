import 'package:flutter/material.dart';

import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';

/// A custom text button
class SPTextButton extends StatelessWidget {

  /// Callback for when the button is tapped
  final void Function()? onTap;

  /// The text to be displayed
  final String text;

  /// Default constructor
  const SPTextButton({
    super.key,
    this.onTap,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: SPText(
          text: text,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: SPColors.blue500,
            decoration: TextDecoration.underline,
            decorationColor: SPColors.blue500
          )
        )
      )
    );
  }
}