import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A class that provides access to environment variables
class Env {

  /// A getter for the Supabase URL
  static String get supabaseUrl => _getKey('SUPABASE_URL');

  /// A getter for the Supabase anonymous key
  static String get supabaseAnonKey => _getKey('SUPABASE_ANON_KEY');

  /// Helper method to get the value of an environment variable
  static String _getKey(String key) {
    return dotenv.env[key]!;
  }
}