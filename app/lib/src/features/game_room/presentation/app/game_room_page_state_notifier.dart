import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:sipardy_app/src/features/game_room/presentation/app/game_room_is_syncing_notifier.dart';
import 'package:sipardy_app/src/models/game_room_player.dart';
import 'package:sipardy_app/core/utils/enums/game_action.dart';
import 'package:sipardy_app/src/models/game_room_question.dart';
import 'package:sipardy_app/src/models/game_room.dart';

part 'game_room_page_state_notifier.g.dart';

/// State Notifier for the Game Room
@riverpod
class GameRoomPageStateNotifier extends _$GameRoomPageStateNotifier {

  @override
  Stream<GameRoom> build(String roomId) {
    return Supabase.instance.client
      .from('game_rooms')
      .stream(primaryKey: ['id'])
      .eq('id', roomId)
      .limit(1)
      .asyncMap<GameRoom>((List<Map<String, dynamic>> dataList) async {
        final Map<String, dynamic> data = dataList.first;
        
        data['players'] = await Supabase.instance.client
          .from('game_room_players')
          .select('*')
          .eq('room_id', roomId);
        
        data['questions'] = await Supabase.instance.client
          .from('game_room_questions')
          .select('*, game_questions(*)')
          .eq('room_id', roomId);

        return GameRoom.fromJson(data);
      });
  }

  /// Updates the state based on chossing a question
  /// When something goes wrong the state will be reset
  Future<void> chooseQuestion(String questionId, int playerPosition) async {
    void updateState({ required bool revert }) {
      final List<GameRoomQuestion> updatedQuestions = state.value!.questions.map<GameRoomQuestion>((GameRoomQuestion question) {
        if (question.questionId == questionId) {
          return question.copyWith(
            selected: !revert,
            playerPosition: revert ? null : playerPosition
          );
        }
        return question;
      }).toList();

      state = AsyncValue.data(state.value!.copyWith(
        currentAction: revert ? GameAction.choose : GameAction.showQuestion,
        questions: updatedQuestions
      ));
    }
    
    updateState(revert: false);

    ref.watch(gameRoomIsSyncingNotifierProvider.notifier).setIsSyncing();

    try {
      await Supabase.instance.client.rpc('app_choose_question', params: <String, dynamic>{
        'in_room_id' : roomId,
        'in_question_id' : questionId,
        'in_player_position' : playerPosition
      });
    } catch (e) {
      updateState(revert: true);
      state = AsyncValue.error(e, StackTrace.current);
    }

    ref.watch(gameRoomIsSyncingNotifierProvider.notifier).setIsNotSyncing();
  }

  /// Updates the state based on showing an answer
  /// When something goes wrong the state will be reset
  Future<void> showAnswer() async {
    void updateState({ required bool revert }) {
      state = AsyncValue.data(state.value!.copyWith(
        currentAction: revert ? GameAction.showQuestion : GameAction.showAnswer
      ));
    }
    
    updateState(revert: false);

    ref.watch(gameRoomIsSyncingNotifierProvider.notifier).setIsSyncing();

    try {
      await Supabase.instance.client.rpc('app_show_answer', params: <String, dynamic>{
        'in_room_id' : roomId
      });
    } catch (e) {
      updateState(revert: true);
      state = AsyncValue.error(e, StackTrace.current);
    }

    ref.watch(gameRoomIsSyncingNotifierProvider.notifier).setIsNotSyncing();
  }

  /// Updates the state based on answering wether the answer was correct
  /// When something goes wrong the state will be reset
  Future<void> answer({ required bool correct }) async {
    final GameRoomQuestion currentQuestion = state.value!.questions.firstWhere((GameRoomQuestion question) => question.selected);
    final int currentPlayerPosition = state.value!.playerTurn.position;
    final int nextPlayerPosition = currentPlayerPosition == state.value!.players.length ? 1 : currentPlayerPosition + 1;

    void updateState({ required bool revert }) {
      final List<GameRoomQuestion> updatedQuestions = state.value!.questions.map<GameRoomQuestion>((GameRoomQuestion question) {
        if (question.questionId == currentQuestion.questionId) {
          return question.copyWith(
            selected: revert,
            answer: correct,
            removeAnswer: revert
          );
        }
        return question;
      }).toList();

      final List<GameRoomPlayer> updatedPlayers = state.value!.players.map<GameRoomPlayer>((GameRoomPlayer player) {
        if (player.position == currentPlayerPosition) {
          return player.copyWith(
            hasTurn: revert,
            points: player.points + (revert ? -currentQuestion.details.points : currentQuestion.details.points)
          );
        }
        if (player.position == nextPlayerPosition) return player.copyWith(hasTurn: !revert);
        return player;
      }).toList();

      state = AsyncValue.data(state.value!.copyWith(
        currentAction: revert ? GameAction.showAnswer : GameAction.choose,
        questions: updatedQuestions,
        players: updatedPlayers
      ));
    }
    
    updateState(revert: false);

    ref.watch(gameRoomIsSyncingNotifierProvider.notifier).setIsSyncing();

    try {
      await Supabase.instance.client.rpc('app_answer', params: <String, dynamic>{
        'in_room_id' : roomId,
        'in_correct' : correct
      });
    } catch (e) {
      updateState(revert: true);
      state = AsyncValue.error(e, StackTrace.current);
    }

    ref.watch(gameRoomIsSyncingNotifierProvider.notifier).setIsNotSyncing();
  }
}