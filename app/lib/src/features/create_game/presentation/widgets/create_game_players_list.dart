import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:sipardy_app/core/common/widgets/sp_chip.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/utils/player_utils.dart';

/// A list of players
class CreateGamePlayersList extends StatelessWidget {

  /// The player names
  final List<String> playerNames;

  /// Whether the list is enabled
  final bool isEnabled;

  /// The callback when a player is pressed
  final void Function(int)? onPressed;

  /// Default constructor
  const CreateGamePlayersList({
    super.key,
    required this.playerNames,
    this.isEnabled = true,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    if (playerNames.isEmpty) {
      return const SPText(
        text: 'Keine Spieler*innen bisher...',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: SPColors.gray300,
          fontStyle: FontStyle.italic
        )
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: SPSpacing.md,
          runSpacing: SPSpacing.md,
          children: List.generate(playerNames.length, (int index) {
            final String playerName = playerNames[index];
            return SPChip.clickable(
              onPressed: () => onPressed?.call(index),
              title: playerName,
              isEnabled: isEnabled,
              backgroundColor: PlayerUtils.getColorForIndex(index),
              foregroundColor: SPColors.white
            );
          })
        ),
        const Gap(SPSpacing.md),
        const SPText(
          text: 'Zum Entfernen auf Namen klicken',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: SPColors.gray300,
            fontStyle: FontStyle.italic
          )
        )
      ]
    );
  }
}