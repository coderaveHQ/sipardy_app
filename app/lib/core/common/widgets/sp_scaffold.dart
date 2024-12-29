import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sipardy_app/core/common/widgets/sp_app_bar.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';

/// A custom Scaffold
class SPScaffold extends StatelessWidget {

  /// The background color
  final Color backgroundColor;

  /// The App Bar
  final SPAppBar? appBar;
  
  /// The body
  final Widget? body;

  /// Default constructor
  const SPScaffold({
    super.key,
    this.backgroundColor = SPColors.primaryBackground,
    this.appBar,
    this.body
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: SPColors.primaryBackground,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: SPColors.primaryBackground,
        statusBarColor: SPColors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar,
        body: body
      )
    );
  }
}