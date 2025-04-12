import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sipardy_app/core/res/localization/custom_localization.dart';
import 'package:sipardy_app/core/res/localization/custom_localization_data.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_mode.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_mode_notifier.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/services/router.dart';

/// The application
class App extends ConsumerStatefulWidget {

  /// Default constructor
  const App({ super.key });

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with WidgetsBindingObserver {

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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    final CustomLanguageMode languageMode = ref.read(customLanguageModeNotifierProvider);
    if (languageMode == CustomLanguageMode.system) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    final GoRouter router = ref.watch(routerProvider);
    final CustomLanguageMode languageMode = ref.watch(customLanguageModeNotifierProvider);
    
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
              Expanded(
                child: CustomLocalization(
                  data: CustomLocalizationData(
                    languageMode: languageMode
                  ), 
                  child: child!
                )
              )
            ]
          );
        }
      )
    );
  }
}