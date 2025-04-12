import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:sipardy_app/core/common/widgets/sp_button.dart';
import 'package:sipardy_app/core/common/widgets/sp_max_size.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/res/localization/custom_localization.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_data.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/utils/constants/ui_constants.dart';

/// Shows a dialog for when a game is finished
Future<void> showGameRoomEndCard(BuildContext context) async {
  double randomInRange(double min, double max) {
    return min + Random().nextDouble() * (max - min);
  }

  const int total = 10;
  int progress = 0;

  Timer.periodic(const Duration(milliseconds: 250), (timer) {
    progress++;

    if (progress >= total) {
      timer.cancel();
      return;
    }

    int count = ((1 - progress / total) * 50).toInt();

    Confetti.launch(
      context,
      options: ConfettiOptions(
          particleCount: count,
          startVelocity: 30,
          spread: 360,
          ticks: 60,
          x: randomInRange(0.1, 0.3),
          y: Random().nextDouble() - 0.2),
    );

    Confetti.launch(
      context,
      options: ConfettiOptions(
          particleCount: count,
          startVelocity: 30,
          spread: 360,
          ticks: 60,
          x: randomInRange(0.7, 0.9),
          y: Random().nextDouble() - 0.2),
    );
  });

  // Show the actual dialog
  await showDialog(
    context: context, 
    builder: (BuildContext context) => const GameRoomEndCard()
  );
}

/// Widget for the end card of a game
class GameRoomEndCard extends StatelessWidget {

  /// Default constructor
  const GameRoomEndCard({ super.key });

  /// Handles when the button was pressed
  void _onPressed(BuildContext context) => context.pop();

  @override
  Widget build(BuildContext context) {

    final CustomLanguageData language = CustomLocalization.of(context).language;
    
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
                text: language.gameRoomEndCardTitle,
                alignment: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                  color: SPColors.white
                )
              ),
              const Gap(SPSpacing.lg),
              SPButton(
                onPressed: () => _onPressed(context),
                title: language.gameRoomEndCardQuitGameButtonTitle
              )
            ]
          )
        )
      )
    );
  }
}