import 'dart:async';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:sipardy_app/core/common/widgets/sp_button.dart';
import 'package:sipardy_app/core/common/widgets/sp_chip.dart';
import 'package:sipardy_app/core/common/widgets/sp_max_size.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/res/localization/custom_localization.dart';
import 'package:sipardy_app/core/res/localization/custom_localization_data.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_data.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/utils/constants/ui_constants.dart';
import 'package:sipardy_app/core/utils/player_utils.dart';
import 'package:sipardy_app/src/models/game_room_player.dart';
import 'package:sipardy_app/src/models/game_room_question.dart';

/// Shows a dialog with details about the question
Future<void> showGameRoomQuestionDetailsCard(BuildContext context, {
  required GameRoomQuestion question,
  required GameRoomPlayer player,
  required void Function(bool) onSetRecommendation
}) async {
  await showDialog(
    context: context, 
    builder: (BuildContext context) => GameRoomQuestionDetailsCard(
      question: question,
      player: player,
      onSetRecommendation: onSetRecommendation
    )
  );
}

/// Widget for the game room question details
class GameRoomQuestionDetailsCard extends StatelessWidget {

  /// The question selected
  final GameRoomQuestion question;

  /// The player that answered this question
  final GameRoomPlayer player;

  /// Sets the recommendation for the selected question
  final void Function(bool) onSetRecommendation;

  /// Default constructor
  const GameRoomQuestionDetailsCard({ 
    super.key,
    required this.question,
    required this.player,
    required this.onSetRecommendation
  });

  /// Handles when the button was pressed
  void _onPressed(BuildContext context) => context.pop();

  @override
  Widget build(BuildContext context) {

    final CustomLocalizationData localization = CustomLocalization.of(context);
    final CustomLanguageData language = localization.language;

    return Dialog(
      backgroundColor: SPColors.primaryBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SPMaxSize.width(
        width: UIConstants.maxWidthBreakpoint, 
        child: Padding(
          padding: const EdgeInsets.all(SPSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SPText(
                text: language.gameRoomQuestionDetailsTitle,
                alignment: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                  color: SPColors.white
                )
              ),
              const Gap(SPSpacing.lg),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SPText(
                    text: language.gameRoomQuestionDetailsQuestion,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: SPColors.white
                    )
                  ),
                  const Gap(SPSpacing.md),
                  Expanded(
                    child: SPText(
                      text: localization.chooseLanguage(
                        en: question.details.questionEn, 
                        de: question.details.questionDe,
                        it: question.details.questionIt
                      ),
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: SPColors.white
                      )
                    )
                  )
                ]
              ),
              const Gap(SPSpacing.md),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SPText(
                    text: language.gameRoomQuestionDetailsAnswer,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: SPColors.white
                    )
                  ),
                  const Gap(SPSpacing.md),
                  Expanded(
                    child: SPText(
                      text: localization.chooseLanguage(
                        en: question.details.answerEn, 
                        de: question.details.answerDe,
                        it: question.details.answerIt
                      ),
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: SPColors.white
                      )
                    )
                  )
                ]
              ),
              const Gap(SPSpacing.md),
              Row(
                children: [
                  SPText(
                    text: language.gameRoomQuestionDetailsAnswered,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: SPColors.white
                    )
                  ),
                  const Gap(SPSpacing.md),
                  Flexible(
                    child: SPChip.basic(
                      title: player.name,
                      backgroundColor: PlayerUtils.getColorForPosition(player.position),
                      foregroundColor: SPColors.white
                    )
                  )
                ]
              ),
              const Gap(SPSpacing.md),
              Row(
                children: [
                  SPText(
                    text: language.gameRoomQuestionDetailsCorrect,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: SPColors.white
                    )
                  ),
                  const Gap(SPSpacing.md),
                  Flexible(
                    child: SPChip.basic(
                      title: question.answer! ? language.gameRoomQuestionDetailsRight : language.gameRoomQuestionDetailsWrong,
                      backgroundColor: question.answer! ? SPColors.green500 : SPColors.red500,
                      foregroundColor: SPColors.white
                    )
                  )
                ]
              ),
              const Gap(SPSpacing.md),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => onSetRecommendation.call(true),
                    child: Icon(
                      LucideIcons.thumbsUp,
                      color: question.recommendation == true ? SPColors.green500 : SPColors.gray100,
                      size: 20.0
                    )
                  ),
                  const Gap(SPSpacing.lg),
                  GestureDetector(
                    onTap: () => onSetRecommendation.call(false),
                    child: Icon(
                      LucideIcons.thumbsDown,
                      color: question.recommendation == false ? SPColors.red500 : SPColors.gray100,
                      size: 20.0
                    )
                  )
                ]
              ),  
              const Gap(SPSpacing.lg),
              SPButton(
                onPressed: () => _onPressed(context),
                title: language.gameRoomQuestionDetailsCloseButtonTitle
              )
            ]
          )
        )
      )
    );
  }
}