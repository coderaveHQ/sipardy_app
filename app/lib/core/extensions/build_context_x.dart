import 'package:flutter/material.dart';

/// A class containing extension methods for the BuildContext class
extension BuildContextX on BuildContext {
  
  /// Returns the MediaQueryData of the current context
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the size of the screen
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Returns the height of the screen
  double get screenHeight => screenSize.height;

  /// Returns the width of the screen
  double get screenWidth => screenSize.width;

  /// Returns the padding of the screen
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// Returns the left padding of the screen
  double get leftPadding => padding.left;

  /// Returns the top padding of the screen
  double get topPadding => padding.top;

  /// Returns the right padding of the screen
  double get rightPadding => padding.right;

  /// Returns the bottom padding of the screen
  double get bottomPadding => padding.bottom;

  /// Returns the vertical padding of the screen
  double get verticalPadding => padding.top + padding.bottom;

  /// Returns the horizontal padding of the screen
  double get horizontalPadding => padding.left + padding.right;

  /// Returns the bottom padding of the screen or the keyboard height if shown
  double get bottomPaddingOrKeyboard {
    if (isKeyboardShown) return currentKeyboardHeight;
    return bottomPadding;
  }

  /// Returns the bottom padding of the screen or 0.0 if keyboard is shown
  double get bottomPaddingOrZeroWhenKeyboard {
    if (isKeyboardShown) return 0.0;
    return bottomPadding;
  }

  /// Returns the current keyboard height
  double get currentKeyboardHeight => mediaQuery.viewInsets.bottom;

  /// Returns whether the keyboard is shown
  bool get isKeyboardShown => currentKeyboardHeight > 0.0;
}