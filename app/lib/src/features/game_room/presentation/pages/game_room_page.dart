import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sipardy_app/core/common/widgets/sp_app_bar.dart';
import 'package:sipardy_app/core/common/widgets/sp_circular_progress_indicator.dart';
import 'package:sipardy_app/core/common/widgets/sp_max_size.dart';
import 'package:sipardy_app/core/common/widgets/sp_scaffold.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/extensions/object_x.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/utils/constants/ui_constants.dart';
import 'package:sipardy_app/src/features/game_room/presentation/app/game_room_is_syncing_notifier.dart';
import 'package:sipardy_app/src/features/game_room/presentation/app/game_room_page_state_notifier.dart';
import 'package:sipardy_app/src/features/game_room/presentation/widgets/game_room_action.dart';
import 'package:sipardy_app/src/features/game_room/presentation/widgets/game_room_board.dart';
import 'package:sipardy_app/src/features/game_room/presentation/widgets/game_room_end_card.dart';
import 'package:sipardy_app/src/features/game_room/presentation/widgets/game_room_player_turn.dart';
import 'package:sipardy_app/src/features/game_room/presentation/widgets/game_room_players.dart';
import 'package:sipardy_app/src/features/game_room/presentation/widgets/game_room_question_details.dart';
import 'package:sipardy_app/src/models/game_room.dart';
import 'package:sipardy_app/src/models/game_room_player.dart';
import 'package:sipardy_app/src/models/game_room_question.dart';

/// Page for the game room
class GameRoomPage extends ConsumerStatefulWidget {

  /// Room ID
  final String roomId;

  /// Default constructor
  const GameRoomPage({
    super.key,
    required this.roomId
  });

  @override
  ConsumerState<GameRoomPage> createState() => _GameRoomPageState();
}

class _GameRoomPageState extends ConsumerState<GameRoomPage> {

  /// Provider for the State Notifier that handles the pages state
  GameRoomPageStateNotifierProvider get _pageStateNotifierProvider => gameRoomPageStateNotifierProvider(widget.roomId);

  /// Action on choosing a question
  Future<void> chooseQuestion(String questionId, int playerPosition) async {
    await ref.read(_pageStateNotifierProvider.notifier).chooseQuestion(questionId, playerPosition);
  }

  /// Shows question details in a dialog
  Future<void> showQuestionDetails(GameRoom room, String questionId) async {
    final GameRoomQuestion tempQuestion = room.questions.firstWhere((GameRoomQuestion questions) => questions.questionId == questionId);
    final GameRoomPlayer tempPlayer = room.players.firstWhere((GameRoomPlayer player) => player.position == tempQuestion.playerPosition);
    await showGameRoomQuestionDetailsCard(context, question: tempQuestion, player: tempPlayer);
  }

  /// Action on showing the answer
  Future<void> showAnswer() async {
    await ref.read(_pageStateNotifierProvider.notifier).showAnswer();
  }

  /// Action on answering
  Future<void> answer(bool correct) async {
    await ref.read(_pageStateNotifierProvider.notifier).answer(correct: correct);
  }

  /// Handles the finished state of the game
  Future<void> _handleGameFinished() async {
    await showGameRoomEndCard(context);
  }

  /// Handles error cases only by showing a toast
  void _handleGameRoomPageStateUpdate(AsyncValue<GameRoom>? last, AsyncValue<GameRoom> next) {
    if (next.hasError) next.error!.showErrorToast(context);
    if (next.value?.isGameFinished ?? false) _handleGameFinished();
  }

  @override
  Widget build(BuildContext context) {

    final AsyncValue<GameRoom> pageState = ref.watch(_pageStateNotifierProvider);
    final bool isSyncing = ref.watch(gameRoomIsSyncingNotifierProvider);

    ref.listen(_pageStateNotifierProvider, _handleGameRoomPageStateUpdate);

    return SPScaffold(
      appBar: SPAppBar(
        title: 'Raum: ${ widget.roomId }',
        backButton: const SPAppBarBackButton(),
        extra: isSyncing
          ? const SPCircularProgressIndicator(
            color: SPColors.white,
            size: 16.0
          )
          : null
      ),
      body: pageState.when(
        data: (GameRoom room) => Column(
          children: [
            GameRoomPlayers(players: room.players, questions: room.questions),
            GameRoomPlayerTurn(player: room.playerTurn),
            Expanded(
              child: GameRoomBoard(
                questions: room.questions,
                onChooseQuestion: (String questionId) => chooseQuestion(questionId, room.playerTurn.position),
                onQuestionDetails: (String questionId) => showQuestionDetails(room, questionId),
                isAnyQuestionSelected: room.isAnyQuestionSelected
              )
            ),
            GameRoomAction(
              action: room.currentAction,
              question: room.selectedQuestion,
              onShowAnswer: showAnswer,
              onAnswer: answer
            )
          ]
        ),
        error: (Object e, StackTrace s) => Center(
          child: SPMaxSize.width(
            width: UIConstants.maxWidthBreakpoint, 
            child: SPText(
              text: e.errorMessage,
              alignment: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: SPColors.white
              )
            )
          )
        ),
        loading: () => const Center(
          child: SPCircularProgressIndicator(
            size: 16.0,
            color: SPColors.white
          )
        )
      )
    );
  }
}