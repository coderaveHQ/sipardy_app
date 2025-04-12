import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:sipardy_app/core/common/widgets/sp_chip.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/extensions/build_context_x.dart';
import 'package:sipardy_app/core/res/localization/custom_localization.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_data.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/utils/player_utils.dart';
import 'package:sipardy_app/src/models/game_room_player.dart';

/// Widget for showing the current players turn
class GameRoomPlayerTurn extends StatelessWidget {

  /// The player whose turn it is
  final GameRoomPlayer player;

  /// Default constructor
  const GameRoomPlayerTurn({
    super.key,
    required this.player
  });

  @override
  Widget build(BuildContext context) {

    final CustomLanguageData language = CustomLocalization.of(context).language;
    
    return Container(
      width: double.infinity,
      color: SPColors.primaryBackground,
      padding: EdgeInsets.only(
        left: context.leftPadding + SPSpacing.lg,
        right: context.rightPadding + SPSpacing.lg,
        top: SPSpacing.sm,
        bottom: SPSpacing.sm
      ),
      child: Row(
        children: [
          Flexible(
            child: SPText(
              text: language.gameRoomPlayerTurn,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: SPColors.white
              )
            )
          ),
          const Gap(SPSpacing.md),
          SPChip.basic(
            title: player.name,
            backgroundColor: PlayerUtils.getColorForPosition(player.position),
            foregroundColor: SPColors.white
          )
        ]
      )
    );
  }
}