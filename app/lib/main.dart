import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:sipardy_app/core/utils/env.dart';
import 'package:sipardy_app/src/app.dart';

/// The main entry point for the application
Future<void> main() async {

  // Ensure that the widgets binding is initialized
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Show the splash screen
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Set the preferred orientations
  await SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp ]);

  // Load the environment variables
  await loadEnv();

  // Initialize the Supabase client
  await initializeSupabase();

  // Run the application
  runApp(
    const ProviderScope(
      child: App()
    )
  );

  // Configure the desktop window
  configureDesktopWindow();

  // Remove the splash screen
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) FlutterNativeSplash.remove();
}

/// Loads the environment variables
Future<void> loadEnv() async {
  await dotenv.load();
}

/// Initializes the Supabase client
Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(detectSessionInUri: false)
  );
}

/// Configures the desktop window
void configureDesktopWindow() {
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) return;
  doWhenWindowReady(() {
    const initialSize = Size(600.0, 450.0);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}