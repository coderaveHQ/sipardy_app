import 'dart:math';

import 'package:flutter/material.dart';

import 'package:sipardy_app/core/res/localization/custom_localization.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_data.dart';

/// Game category enum
enum GameCategory {
  
  /// Animals
  animals(
    dbValue: 'animals',
  ),

  /// Architecture
  architecture(
    dbValue: 'architecture',
  ),

  /// Art
  art(
    dbValue: 'art',
  ),

  /// Board Games
  boardGames(
    dbValue: 'board_games',
  ),

  /// Capitals
  capitals(
    dbValue: 'capitals',
  ),

  /// Chemistry
  chemistry(
    dbValue: 'chemistry',
  ),

  /// Coding
  coding(
    dbValue: 'coding',
  ),

  /// Comics
  comics(
    dbValue: 'comics',
  ),

  /// Culture
  culture(
    dbValue: 'culture',
  ),

  /// Economics
  economics(
    dbValue: 'economics',
  ),

  /// Famous People
  famousPeople(
    dbValue: 'famous_people',
  ),

  /// Food and Drinks
  foodAndDrinks(
    dbValue: 'food_and_drinks',
  ),

  /// Football
  football(
    dbValue: 'football'
  ),

  /// Geography
  geography(
    dbValue: 'geography',
  ),

  /// History
  history(
    dbValue: 'history',
  ),

  /// Languages
  languages(
    dbValue: 'languages',
  ),

  /// League of Legends
  leagueOfLegends(
    dbValue: 'league_of_legends',
  ),

  /// Literature
  literature(
    dbValue: 'literature',
  ),

  /// Math
  math(
    dbValue: 'math',
  ),

  /// Movies
  movies(
    dbValue: 'movies',
  ),

  /// Music
  music(
    dbValue: 'music',
  ),

  /// Mythology
  mythology(
    dbValue: 'mythology',
  ),

  /// Nature
  nature(
    dbValue: 'nature',
  ),

  /// Physics
  physics(
    dbValue: 'physics',
  ),

  /// Politics
  politics(
    dbValue: 'politics',
  ),

  /// Science
  science(
    dbValue: 'science',
  ),

  /// Soccer
  soccer(
    dbValue: 'soccer',
  ),

  /// Space
  space(
    dbValue: 'space',
  ),

  /// Sports
  sports(
    dbValue: 'sports',
  ),

  /// Technology
  technology(
    dbValue: 'technology',
  ),

  /// TV Shows
  tvShows(
    dbValue: 'tv_shows',
  ),

  /// Video Games
  videoGames(
    dbValue: 'video_games',
  ),

  /// Pokémon
  pokemon(
    dbValue: 'pokemon',
  ),

  /// Anime
  anime(
    dbValue: 'anime',
  );

  /// Database value
  final String dbValue;

  /// Default constructor
  const GameCategory({
    required this.dbValue,
  });

  /// Gets the name of the category
  String name(BuildContext context) {
    final CustomLanguageData language = CustomLocalization.of(context).language;
    return switch (this) {
      GameCategory.animals => language.gameCategoryAnimals,
      GameCategory.architecture => language.gameCategoryArchitecture,
      GameCategory.art => language.gameCategoryArt,
      GameCategory.boardGames => language.gameCategoryBoardGames,
      GameCategory.capitals => language.gameCategoryCapitals,
      GameCategory.chemistry => language.gameCategoryChemistry,
      GameCategory.coding => language.gameCategoryCoding,
      GameCategory.comics => language.gameCategoryComics,
      GameCategory.culture => language.gameCategoryCulture,
      GameCategory.economics => language.gameCategoryEconomics,
      GameCategory.famousPeople => language.gameCategoryFamousPeople,
      GameCategory.foodAndDrinks => language.gameCategoryFoodAndDrinks,
      GameCategory.football => language.gameCategoryFootball,
      GameCategory.geography => language.gameCategoryGeography,
      GameCategory.history => language.gameCategoryHistory,
      GameCategory.languages => language.gameCategoryLanguages,
      GameCategory.leagueOfLegends => language.gameCategoryLeagueOfLegends,
      GameCategory.literature => language.gameCategoryLiterature,
      GameCategory.math => language.gameCategoryMath,
      GameCategory.movies => language.gameCategoryMovies,
      GameCategory.music => language.gameCategoryMusic,
      GameCategory.mythology => language.gameCategoryMythology,
      GameCategory.nature => language.gameCategoryNature,
      GameCategory.physics => language.gameCategoryPhysics,
      GameCategory.politics => language.gameCategoryPolitics,
      GameCategory.science => language.gameCategoryScience,
      GameCategory.soccer => language.gameCategorySoccer,
      GameCategory.space => language.gameCategorySpace,
      GameCategory.sports => language.gameCategorySports,
      GameCategory.technology => language.gameCategoryTechnology,
      GameCategory.tvShows => language.gameCategoryTvShows,
      GameCategory.videoGames => language.gameCategoryVideoGames,
      GameCategory.pokemon => language.gameCategoryPokemon,
      GameCategory.anime => language.gameCategoryAnime
    };
  }

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

  /// Gets 5 random categories
  static Map<GameCategory, bool> get randomSelection {
    final Map<GameCategory, bool> initialMap = <GameCategory, bool>{};

    List<GameCategory> categories = GameCategory.values.toList();
    categories.shuffle(Random());
    List<GameCategory> randomCategories = categories.take(5).toList();

    for (GameCategory category in GameCategory.values) { initialMap[category] = randomCategories.contains(category); }

    return initialMap;
  }
}