/// Game category enum
enum GameCategory {
  
  /// Animals
  animals(
    name: 'Tiere',
    dbValue: 'animals',
  ),

  /// Architecture
  architecture(
    name: 'Architektur',
    dbValue: 'architecture',
  ),

  /// Art
  art(
    name: 'Kunst',
    dbValue: 'art',
  ),

  /// Board Games
  boardGames(
    name: 'Brettspiele',
    dbValue: 'board_games',
  ),

  /// Capitals
  capitals(
    name: 'Hauptstädte',
    dbValue: 'capitals',
  ),

  /// Chemistry
  chemistry(
    name: 'Chemie',
    dbValue: 'chemistry',
  ),

  /// Coding
  coding(
    name: 'Programmierung',
    dbValue: 'coding',
  ),

  /// Comics
  comics(
    name: 'Comics',
    dbValue: 'comics',
  ),

  /// Culture
  culture(
    name: 'Kultur',
    dbValue: 'culture',
  ),

  /// Economics
  economics(
    name: 'Wirtschaft',
    dbValue: 'economics',
  ),

  /// Famous People
  famousPeople(
    name: 'Berühmte Persönlichkeiten',
    dbValue: 'famous_people',
  ),

  /// Food and Drinks
  foodAndDrinks(
    name: 'Essen und Getränke',
    dbValue: 'food_and_drinks',
  ),

  /// Geography
  geography(
    name: 'Geografie',
    dbValue: 'geography',
  ),

  /// History
  history(
    name: 'Geschichte',
    dbValue: 'history',
  ),

  /// Languages
  languages(
    name: 'Sprachen',
    dbValue: 'languages',
  ),

  /// League of Legends
  leagueOfLegends(
    name: 'League of Legends',
    dbValue: 'league_of_legends',
  ),

  /// Literature
  literature(
    name: 'Literatur',
    dbValue: 'literature',
  ),

  /// Math
  math(
    name: 'Mathematik',
    dbValue: 'math',
  ),

  /// Movies
  movies(
    name: 'Filme',
    dbValue: 'movies',
  ),

  /// Music
  music(
    name: 'Musik',
    dbValue: 'music',
  ),

  /// Mythology
  mythology(
    name: 'Mythologie',
    dbValue: 'mythology',
  ),

  /// Nature
  nature(
    name: 'Natur',
    dbValue: 'nature',
  ),

  /// Physics
  physics(
    name: 'Physik',
    dbValue: 'physics',
  ),

  /// Politics
  politics(
    name: 'Politik',
    dbValue: 'politics',
  ),

  /// Science
  science(
    name: 'Wissenschaft',
    dbValue: 'science',
  ),

  /// Soccer
  soccer(
    name: 'Fußball',
    dbValue: 'soccer',
  ),

  /// Space
  space(
    name: 'Weltraum',
    dbValue: 'space',
  ),

  /// Sports
  sports(
    name: 'Sport',
    dbValue: 'sports',
  ),

  /// Technology
  technology(
    name: 'Technologie',
    dbValue: 'technology',
  ),

  /// TV Shows
  tvShows(
    name: 'TV-Shows',
    dbValue: 'tv_shows',
  ),

  /// Video Games
  videoGames(
    name: 'Videospiele',
    dbValue: 'video_games',
  );

  /// Name
  final String name;

  /// Database value
  final String dbValue;

  /// Default constructor
  const GameCategory({
    required this.name,
    required this.dbValue,
  });

  /// Converts database value to an enum value
  static GameCategory fromDbValue(String dbValue) {
    return GameCategory.values.firstWhere(
      (GameCategory category) => category.dbValue == dbValue,
      orElse: () => throw ArgumentError('Invalid dbValue: $dbValue'),
    );
  }

  /// Gets the initial selection of the categories when creating a game (nothing selected, yet)
  static Map<GameCategory, bool> get initialSelection {
    final Map<GameCategory, bool> initialMap = <GameCategory, bool>{};
    for (GameCategory category in GameCategory.values) { initialMap[category] = false; }
    return initialMap;
  }
}