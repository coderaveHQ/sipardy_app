import 'package:flutter/material.dart';

import 'package:sipardy_app/core/extensions/build_context_x.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/utils/constants/ui_constants.dart';

/// A class containing utils for the UI
class UIUtils {

  /// Gets the padding that is added to both sides to allow scrolling out of the range of any widget
  static double additionalPaddingForCenteredMaxWidth(BuildContext context) {
    double additionalHorizontalPadding = (context.screenWidth - context.leftPadding - context.rightPadding - 2 * SPSpacing.lg - UIConstants.maxWidthBreakpoint) / 2;
    if (additionalHorizontalPadding < 0.0) additionalHorizontalPadding = 0.0;
    return additionalHorizontalPadding;
  }
}