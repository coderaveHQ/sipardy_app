import 'dart:async';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:sipardy_app/core/common/widgets/sp_button.dart';
import 'package:sipardy_app/core/common/widgets/sp_chip.dart';
import 'package:sipardy_app/core/common/widgets/sp_max_size.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/utils/constants/ui_constants.dart';
import 'package:sipardy_app/core/utils/player_utils.dart';
import 'package:sipardy_app/src/models/game_room_player.dart';
import 'package:sipardy_app/src/models/game_room_question.dart';

/// Shows a dialog with details about the question
Future<void> showGameRoomQuestionDetailsCard(BuildContext context, {
  required GameRoomQuestion question,
  required GameRoomPlayer player
}) async {
  await showDialog(
    context: context, 
    builder: (BuildContext context) => GameRoomQuestionDetailsCard(
      question: question,
      player: player
    )
  );
}

/// Widget for the game room question details
class GameRoomQuestionDetailsCard extends StatelessWidget {

  /// The question selected
  final GameRoomQuestion question;

  /// The player that answered this question
  final GameRoomPlayer player;

  /// Default constructor
  const GameRoomQuestionDetailsCard({ 
    super.key,
    required this.question,
    required this.player
  });

  /// Handles when the button was pressed
  void _onPressed(BuildContext context) => context.pop();

  @override
  Widget build(BuildContext context) {
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
              const SPText(
                text: 'Details',
                alignment: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                  color: SPColors.white
                )
              ),
              const Gap(SPSpacing.lg),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SPText(
                    text: 'FRAGE:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: SPColors.white
                    )
                  ),
                  const Gap(SPSpacing.md),
                  Expanded(
                    child: SPText(
                      text: question.details.question,
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
                  const SPText(
                    text: 'ANTWORT:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: SPColors.white
                    )
                  ),
                  const Gap(SPSpacing.md),
                  Expanded(
                    child: SPText(
                      text: question.details.answer,
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
                  const SPText(
                    text: 'BEANTWORTET:',
                    style: TextStyle(
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
                  const SPText(
                    text: 'KORREKT:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: SPColors.white
                    )
                  ),
                  const Gap(SPSpacing.md),
                  Flexible(
                    child: SPChip.basic(
                      title: question.answer! ? 'Richtig' : 'Falsch',
                      backgroundColor: question.answer! ? SPColors.green500 : SPColors.red500,
                      foregroundColor: SPColors.white
                    )
                  )
                ]
              ),
              const Gap(SPSpacing.lg),
              SPButton(
                onPressed: () => _onPressed(context),
                title: 'OKAY'
              )
            ]
          )
        )
      )
    );
  }
}