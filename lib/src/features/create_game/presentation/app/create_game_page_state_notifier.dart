import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:sipardy_app/core/error/game_creation_error.dart';
import 'package:sipardy_app/core/utils/enums/game_category.dart';

part 'create_game_page_state_notifier.g.dart';

// TODO: Refactor

/// The state notifier for the create game page
@riverpod
class CreateGamePageStateNotifier extends _$CreateGamePageStateNotifier {

  @override
  CreateGamePageState build() {
    return CreateGamePageState.initial();
  }

  /// Adds a player name
  void addPlayerName(String playerName) {
    state = state.copyWith(
      playerNames: List<String>.from(state.playerNames)..add(playerName),
      removeError: true
    );
  }

  /// Removes a player name
  void removePlayerName(int index) {
    final List<String> tempPlayerNames = List<String>.from(state.playerNames);
    tempPlayerNames.removeAt(index);
    state = state.copyWith(
      playerNames: tempPlayerNames,
      removeError: true
    );
  }

  /// Resets the player names
  void resetPlayerNames() {
    state = state.copyWith(
      playerNames: const <String>[],
      removeError: true
    );
  }

  /// Triggers a category by either selecting or deselecting it based on wether it is already selected
  void triggerCategory(GameCategory category) {
    if (!state.categories[category]! && state.selectedCategoriesCount == 5) {
      state = state.copyWith(error: const GameCreationError.alreadyFiveCategoriesPicked());
      return;
    }

    final Map<GameCategory, bool> tempCategories = Map<GameCategory, bool>.from(state.categories);
    tempCategories[category] = !tempCategories[category]!;
    state = state.copyWith(
      categories: tempCategories,
      removeError: true
    );
  }

  /// Creates a game room
  Future<String?> createGameRoom() async {
    state = state.copyWith(
      isCreatingGame: true,
      removeError: true
    );

    try {
      if (state.selectedCategoriesCount < 5) throw const GameCreationError.lessThanFiveCategoriesPicked();
      final String roomId = await Supabase.instance.client.rpc('app_create_game_room', params: <String, dynamic>{
        'selected_categories': state.categories.entries.where((MapEntry<GameCategory, bool> entry) => entry.value).map((MapEntry<GameCategory, bool> entry) => entry.key).toList(),
        'player_names': state.playerNames
      });
      state = state.copyWith(isCreatingGame: false);
      return roomId;
    } catch (e) {
      state = state.copyWith(
        isCreatingGame: false,
        error: e
      );
      return null;
    }
  }
}

/// The state of the create game page
class CreateGamePageState {

  /// Whether the game is being created
  final bool isCreatingGame;

  /// The error that occurred
  final Object? error;

  /// The selected categories
  final Map<GameCategory, bool> categories;

  /// The player names
  final List<String> playerNames;

  /// Default constructor
  const CreateGamePageState({
    this.isCreatingGame = false,
    this.error,
    required this.categories,
    this.playerNames = const <String>[]
  });

  /// The initial state
  factory CreateGamePageState.initial() {
    return CreateGamePageState(
      isCreatingGame: false,
      error: null,
      categories: GameCategory.initialSelection,
      playerNames: const <String>[]
    );
  }

  /// Copy the state with new values
  CreateGamePageState copyWith({
    bool? isCreatingGame,
    Object? error,
    Map<GameCategory, bool>? categories,
    List<String>? playerNames,
    bool removeError = false
  }) {
    return CreateGamePageState(
      isCreatingGame: isCreatingGame ?? this.isCreatingGame,
      error: removeError ? null : error ?? this.error,
      categories: categories ?? this.categories,
      playerNames: playerNames ?? this.playerNames
    );
  }

  /// Gets the current count of selected categories
  int get selectedCategoriesCount => categories.entries.where((MapEntry<GameCategory, bool> entry) => entry.value).length;
}