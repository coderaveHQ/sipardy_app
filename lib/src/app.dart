import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sipardy_app/core/services/router.dart';

/// The application
class App extends ConsumerWidget {

  /// Default constructor
  const App({ super.key });

  /// Unfocuses the primary focus which will be the keyboard most of the time
  void _unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final GoRouter router = ref.watch(routerProvider);
    
    return GestureDetector(
      onTap: _unfocusKeyboard,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router
      )
    );
  }
}