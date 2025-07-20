/// A class that provides access to environment variables
class Env {

  /// A getter for the Supabase URL
  static String get supabaseUrl => const String.fromEnvironment('SUPABASE_URL');

  /// A getter for the Supabase anonymous key
  static String get supabaseAnonKey => const String.fromEnvironment('SUPABASE_ANON_KEY');
}