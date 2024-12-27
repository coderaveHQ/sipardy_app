import 'package:flutter/material.dart';

import 'package:sipardy_app/core/common/widgets/sp_chip.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/extensions/build_context_x.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/utils/player_utils.dart';
import 'package:sipardy_app/src/models/game_room_player.dart';

/// Widget for showing all players and their points
class GameRoomPlayers extends StatelessWidget {

  /// A list of all players in the room
  final List<GameRoomPlayer> players;

  /// Default constructor
  const GameRoomPlayers({
    super.key,
    required this.players
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: SPColors.primaryBackground,
      padding: const EdgeInsets.only(top: SPSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: context.leftPadding + SPSpacing.lg),
            child: const SPText(
              text: 'PUNKTE',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: SPColors.white
              )
            )
          ),
          SizedBox(
            height: 40.0 + 2 * SPSpacing.sm,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                left: context.leftPadding + SPSpacing.lg,
                right: context.rightPadding + SPSpacing.lg,
                top: SPSpacing.sm,
                bottom: SPSpacing.sm
              ),
              itemCount: players.length,
              itemBuilder: (BuildContext context, int index) {
                final GameRoomPlayer player = players[index];
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0.0 : SPSpacing.md),
                  child: SPChip.basic(
                    title: '${ player.name } (${ player.points })',
                    backgroundColor: PlayerUtils.getColorForPosition(player.position),
                    foregroundColor: SPColors.white
                  )
                );
              }
            )
          )
        ]
      )        
    );
  }
}