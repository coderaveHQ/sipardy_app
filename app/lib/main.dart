import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:sipardy_app/core/services/preferences.dart';
import 'package:sipardy_app/src/app.dart';

/// The main entry point for the application
Future<void> main() async {

  // Ensure that the widgets binding is initialized
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Show the splash screen
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize the Supabase client
  await initializeSupabase();

  final Preferences preferences = await _setupPreferences();

  // Run the application
  runApp(
    ProviderScope(
      overrides: [
        preferencesProvider.overrideWithValue(preferences)
      ],
      child: const App()
    )
  );

  // Configure the desktop window
  configureDesktopWindow();

  // Remove the splash screen
  if (kIsWeb || Platform.isAndroid || Platform.isIOS) FlutterNativeSplash.remove();
}

/// Initializes the Supabase client
Future<void> initializeSupabase() async {
  const String supabaseUrl = kDebugMode ? 'http://127.0.0.1:54321' : 'https://jjfaxibrpacbjyjqguug.supabase.co';
  const String supabaseKey = kDebugMode ? 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' : 'sb_publishable_vlcM3Zm0GtRtHkJDa7ABRA_Ux6z8OrH';
  
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
    authOptions: const FlutterAuthClientOptions(detectSessionInUri: false)
  );
}

Future<Preferences> _setupPreferences() async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return Preferences(sharedPreferences: sharedPreferences);
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