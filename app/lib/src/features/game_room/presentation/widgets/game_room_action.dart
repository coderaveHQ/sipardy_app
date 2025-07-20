import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:sipardy_app/core/common/widgets/sp_button.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/extensions/build_context_x.dart';
import 'package:sipardy_app/core/res/localization/custom_localization.dart';
import 'package:sipardy_app/core/res/localization/custom_localization_data.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_data.dart';
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

  /// Callback for when setting a recommendation
  final void Function(bool) onSetRecommendation;
  
  /// Default constructor
  const GameRoomAction({ 
    super.key,
    required this.action,
    this.question,
    required this.onShowAnswer,
    required this.onAnswer,
    required this.onSetRecommendation
  });

  @override
  Widget build(BuildContext context) {

    final CustomLocalizationData localization = CustomLocalization.of(context);
    
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
          question: localization.chooseLanguage(
            en: question!.details.questionEn,
            de: question!.details.questionDe,
            it: question!.details.questionIt
          ),
          onShowAnswer: onShowAnswer
        ),
        GameAction.showAnswer => GameRoomActionShowAnswer(
          answer: localization.chooseLanguage(
            en: question!.details.answerEn,
            de: question!.details.answerDe,
            it: question!.details.answerIt
          ),
          onAnswer: onAnswer,
          recommendation: question!.recommendation,
          onSetRecommendation: onSetRecommendation
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

    final CustomLanguageData language = CustomLocalization.of(context).language;
    
    return SPText(
      text: language.gameRoomActionChooseOption,
      alignment: TextAlign.center,
      style: const TextStyle(
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

    final CustomLanguageData language = CustomLocalization.of(context).language;

    final bool isSyncing = ref.watch(gameRoomIsSyncingNotifierProvider);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SPText(
              text: language.gameRoomActionQuestion,
              style: const TextStyle(
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
          title: language.gameRoomActionShowAnswer,
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

  /// Wether the user recommends the question
  final bool? recommendation;

  /// Callback for setting a recommendation
  final void Function(bool) onSetRecommendation;

  /// Default constructor
  const GameRoomActionShowAnswer({ 
    super.key,
    required this.answer,
    required this.onAnswer,
    required this.recommendation,
    required this.onSetRecommendation
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final CustomLanguageData language = CustomLocalization.of(context).language;

    final bool isSyncing = ref.watch(gameRoomIsSyncingNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SPText(
              text: language.gameRoomActionAnswer,
              style: const TextStyle(
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
            ),
            const Gap(SPSpacing.md),
            GestureDetector(
              onTap: () => onSetRecommendation.call(true),
              child: Icon(
                LucideIcons.thumbsUp,
                color: recommendation == true ? SPColors.green500 : SPColors.gray100,
                size: 20.0
              )
            ),
            const Gap(SPSpacing.lg),
            GestureDetector(
              onTap: () => onSetRecommendation.call(false),
              child: Icon(
                LucideIcons.thumbsDown,
                color: recommendation == false ? SPColors.red500 : SPColors.gray100,
                size: 20.0
              )
            )
          ]
        ),
        const Gap(SPSpacing.lg),
        SPText(
          text: language.gameRoomActionIsCorrect,
          style: const TextStyle(
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
                title: language.gameRoomActionRight,
                isEnabled: !isSyncing
              )
            ),
            const Gap(SPSpacing.md),
            Expanded(
              child: SPButton(
                onPressed: () => onAnswer.call(false),
                backgroundColor: SPColors.red500,
                foregroundColor: SPColors.white,
                title: language.gameRoomActionWrong,
                isEnabled: !isSyncing
              )
            )
          ]
        )
      ]
    );
  }
}