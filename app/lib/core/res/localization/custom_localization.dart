import 'package:flutter/material.dart';

import 'package:sipardy_app/core/res/localization/custom_localization_data.dart';

/// A wrapper class for holding localization data
class CustomLocalization extends InheritedWidget {

  /// The actual localization data
  final CustomLocalizationData data;

  /// Default constructor
  const CustomLocalization({
    super.key,
    required this.data,
    required super.child
  });

  /// A method for finding an instance of itself in the widget tree
  static CustomLocalizationData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomLocalization>()!.data;
  }

  @override
  bool updateShouldNotify(covariant CustomLocalization oldWidget) {
    return data != oldWidget.data;
  }
}