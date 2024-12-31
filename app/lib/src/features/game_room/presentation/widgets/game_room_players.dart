import 'package:flutter/material.dart';

import 'package:sipardy_app/core/common/widgets/sp_chip.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/extensions/build_context_x.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/utils/player_utils.dart';
import 'package:sipardy_app/src/models/game_room_player.dart';
import 'package:sipardy_app/src/models/game_room_question.dart';

/// Widget for showing all players and their points
class GameRoomPlayers extends StatelessWidget {

  /// A list of all players in the room
  final List<GameRoomPlayer> players;

  /// A list of all question to calculate the correct and wrong counters
  final List<GameRoomQuestion> questions;

  /// Default constructor
  const GameRoomPlayers({
    super.key,
    required this.players,
    required this.questions
  });

  /// Gets the players ordered by their position
  List<GameRoomPlayer> get _orderedPlayers {
    final List<GameRoomPlayer> playersList = List<GameRoomPlayer>.from(players);
    playersList.sort((GameRoomPlayer a, GameRoomPlayer b) => a.position.compareTo(b.position));
    return playersList;
  }

  /// Calculates the right and wrong counts for a player
  ({ int rightCount, int wrongCount }) calculateRightWrongCountsForPlayer(int playerPosition) {
    int rightCount = 0;
    int wrongCount = 0;

    for (GameRoomQuestion question in questions) {
      if (question.playerPosition == playerPosition && question.answer != null) {
        if (question.answer!) {
          rightCount++;
        } else {
          wrongCount++;
        }
      }
    }

    return (rightCount: rightCount, wrongCount: wrongCount);
  }

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
              itemCount: _orderedPlayers.length,
              itemBuilder: (BuildContext context, int index) {
                final GameRoomPlayer player = _orderedPlayers[index];
                final ({ int rightCount, int wrongCount }) counts = calculateRightWrongCountsForPlayer(player.position);
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0.0 : SPSpacing.md),
                  child: SPChip.basic(
                    title: '${ player.name } (${ player.points }, R: ${ counts.rightCount }, F: ${ counts.wrongCount })',
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