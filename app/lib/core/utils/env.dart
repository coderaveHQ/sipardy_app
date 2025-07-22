/// A class that provides access to environment variables
class Env {

  /// A getter for the Supabase URL
  static String get supabaseUrl => 'https://jjfaxibrpacbjyjqguug.supabase.co'; // const String.fromEnvironment('SUPABASE_URL');

  /// A getter for the Supabase anonymous key
  static String get supabaseAnonKey => 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpqZmF4aWJycGFjYmp5anFndXVnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU1OTExMTQsImV4cCI6MjA1MTE2NzExNH0.e_TQ6ubEL_lNCAygDfOknlTTcfLSVySYDYAJWaVJmUg'; // const String.fromEnvironment('SUPABASE_ANON_KEY');
}