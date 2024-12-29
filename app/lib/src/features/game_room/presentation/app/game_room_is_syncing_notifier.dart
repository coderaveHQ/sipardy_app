import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_room_is_syncing_notifier.g.dart';

/// Notifier for indicating if the game is currently syncing with Supabase to disable relevant components. 
/// Default is `false`.
@riverpod
class GameRoomIsSyncingNotifier extends _$GameRoomIsSyncingNotifier {

  @override
  bool build() => false;

  /// Sets the value to `true`
  void setIsSyncing() => state = true;

  /// Sets the value to `false`
  void setIsNotSyncing() => state = false;
}