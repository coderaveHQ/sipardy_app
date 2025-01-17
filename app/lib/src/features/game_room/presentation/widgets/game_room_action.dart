import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sipardy_app/core/common/widgets/sp_button.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/extensions/build_context_x.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/utils/constants/ui_constants.dart';
import 'package:sipardy_app/core/utils/enums/game_action.dart';
import 'package:sipardy_app/src/features/game_room/presentation/app/game_room_is_syncing_notifier.dart';
import 'package:sipardy_app/src/models/game_room_question.dart';

/// Widget for interacting with the game
class GameRoomAction extends StatelessWidget {

  /// The current game action
  final GameAction action;

  /// The currently selected question
  final GameRoomQuestion? question;

  /// Callback for when the answer should be shown
  final void Function() onShowAnswer;

  /// Callback for when indicating wether the answer was correct
  final void Function(bool) onAnswer;
  
  /// Default constructor
  const GameRoomAction({ 
    super.key,
    required this.action,
    this.question,
    required this.onShowAnswer,
    required this.onAnswer
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UIConstants.maxWidthBreakpoint,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: context.leftPadding + SPSpacing.lg,
        right: context.rightPadding + SPSpacing.lg,
        top: SPSpacing.lg,
        bottom: context.bottomPadding + SPSpacing.lg
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        color: SPColors.tertiaryBackground
      ),
      child: switch (action) {
        GameAction.choose => const GameRoomActionChoose(),
        GameAction.showQuestion => GameRoomActionShowQuestion(
          question: question!.details.question, 
          onShowAnswer: onShowAnswer
        ),
        GameAction.showAnswer => GameRoomActionShowAnswer(
          answer: question!.details.answer,
          onAnswer: onAnswer
        )
      }
    );
  }
}

/// Widget for the choose action
class GameRoomActionChoose extends StatelessWidget {

  /// Default constructor
  const GameRoomActionChoose({ super.key });

  @override
  Widget build(BuildContext context) {
    return const SPText(
      text: 'Bitte wähle eine Option.',
      alignment: TextAlign.center,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: SPColors.white
      )
    );
  }
}

/// Widget for the show question action
class GameRoomActionShowQuestion extends ConsumerWidget {

  /// The plaint text question
  final String question;

  /// Callback for when the answer should be shown
  final void Function() onShowAnswer;

  /// Default constructor
  const GameRoomActionShowQuestion({ 
    super.key,
    required this.question,
    required this.onShowAnswer
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool isSyncing = ref.watch(gameRoomIsSyncingNotifierProvider);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SPText(
              text: 'FRAGE:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: SPColors.white
              )
            ),
            const Gap(SPSpacing.md),
            Expanded(
              child: SPText(
                text: question,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: SPColors.white
                )
              )
            )
          ]
        ),
        const Gap(SPSpacing.lg),
        SPButton(
          onPressed: onShowAnswer,
          title: 'Antwort anzeigen',
          isEnabled: !isSyncing
        )
      ]
    );
  }
}

/// Widget for the show answer action
class GameRoomActionShowAnswer extends ConsumerWidget {

  /// The plain text answer
  final String answer;

  /// Callback for when indicating wether the answer was correct
  final void Function(bool) onAnswer;

  /// Default constructor
  const GameRoomActionShowAnswer({ 
    super.key,
    required this.answer,
    required this.onAnswer
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool isSyncing = ref.watch(gameRoomIsSyncingNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SPText(
              text: 'ANTWORT:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: SPColors.white
              )
            ),
            const Gap(SPSpacing.md),
            Expanded(
              child: SPText(
                text: answer,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: SPColors.white
                )
              )
            )
          ]
        ),
        const Gap(SPSpacing.lg),
        const SPText(
          text: 'Wurde die Frage korrekt beantwortet?',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: SPColors.white,
            fontStyle: FontStyle.italic
          )
        ),
        const Gap(SPSpacing.lg),
        Row(
          children: [
            Expanded(
              child: SPButton(
                onPressed: () => onAnswer.call(true),
                backgroundColor: SPColors.green500,
                foregroundColor: SPColors.white,
                title: 'Richtig',
                isEnabled: !isSyncing
              )
            ),
            const Gap(SPSpacing.md),
            Expanded(
              child: SPButton(
                onPressed: () => onAnswer.call(false),
                backgroundColor: SPColors.red500,
                foregroundColor: SPColors.white,
                title: 'Falsch',
                isEnabled: !isSyncing
              )
            )
          ]
        )
      ]
    );
  }
}