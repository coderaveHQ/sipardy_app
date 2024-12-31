import 'package:flutter/material.dart';

import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/utils/enums/game_category.dart';
import 'package:sipardy_app/src/models/game_room_question.dart';

// TODO: Refactor

/// Type of the game room board card
enum GameRoomBoardCardType {
  /// Category
  category,
  /// Question
  question
}

/// Widget for the game room board card
class GameRoomBoardCard extends StatelessWidget {

  /// Callback for when the card was selected
  final void Function()? onPressed;

  /// Callback for when the card was long pressed
  final void Function()? onLongPressed;

  /// Type of the card
  final GameRoomBoardCardType type;

  /// Category
  final GameCategory? category;

  /// Question
  final GameRoomQuestion? question;

  /// Inidicates if the card can be pressed
  final bool isEnabled;

  /// Constrcutor for the category card
  const GameRoomBoardCard.category({
    super.key,
    required this.category
  })  : type = GameRoomBoardCardType.category,
        question = null,
        onPressed = null,
        onLongPressed = null,
        isEnabled = false;

  /// Constrcutor for the question card
  const GameRoomBoardCard.question({
    super.key,
    this.onPressed,
    this.onLongPressed,
    required this.question,
    required this.isEnabled
  })  : type = GameRoomBoardCardType.question,
        category = null;

  /// Gets the title of the card
  String get _title => category?.name ?? question!.details.points.toString();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: type == GameRoomBoardCardType.category ? 60.0 : 50.0,
      child: RawMaterialButton(
        onPressed: isEnabled ? onPressed : null,
        onLongPress: type == GameRoomBoardCardType.question && question!.answer != null ? onLongPressed : null,
        enableFeedback: isEnabled,
        fillColor: type == GameRoomBoardCardType.category ? SPColors.primaryButtonBackground : question!.selected ? SPColors.blue500 : question!.answer == null ? SPColors.secondaryBackground : question!.answer! ? SPColors.green500 : SPColors.red500,
        padding: const EdgeInsets.all(SPSpacing.sm),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Center(
          child: SPText(
            text: _title,
            alignment: TextAlign.center,
            style: TextStyle(
              fontSize: type == GameRoomBoardCardType.question ? 16.0 : 11.0,
              fontWeight: FontWeight.w600,
              color: SPColors.white
            )
          )
        )
      )
    );
  }
}