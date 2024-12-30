import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/services/router.dart';

/// The application
class App extends ConsumerWidget {

  /// Default constructor
  const App({ super.key });

  /// Unfocuses the primary focus which will be the keyboard most of the time
  void _unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// A list of title bar items for desktop platforms
  List<Widget> get _titleBarItems {
    if (Platform.isMacOS) {
      return <Widget>[
        CloseWindowButton(),
        MinimizeWindowButton(),
        MaximizeWindowButton(),
        Expanded(child: MoveWindow())
      ];
    }

    return <Widget>[
      Expanded(child: MoveWindow()),
      MinimizeWindowButton(),
      MaximizeWindowButton(),
      CloseWindowButton()
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final GoRouter router = ref.watch(routerProvider);
    
    return GestureDetector(
      onTap: _unfocusKeyboard,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        builder: (BuildContext context, Widget? child) {
          return Column(
            children: [
              if (!kIsWeb && (Platform.isWindows || Platform.isMacOS)) Container(
                height: appWindow.titleBarHeight,
                color: SPColors.primaryBackground,
                child: Row(children: _titleBarItems)
              ),
              Expanded(child: child!)
            ]
          );
        }
      )
    );
  }
}