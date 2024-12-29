import 'package:flutter/material.dart';

import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';

/// A custom circular progress indicator
class SPCircularProgressIndicator extends StatelessWidget {

  /// The size
  final double size;

  /// The color
  final Color color;

  /// Default constructor
  const SPCircularProgressIndicator({
    super.key,
    this.size = 18.0,
    this.color = SPColors.gray900
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(color: color)
    );
  }
}