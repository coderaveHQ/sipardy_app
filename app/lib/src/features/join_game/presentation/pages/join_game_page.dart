import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import 'package:sipardy_app/core/common/widgets/sp_app_bar.dart';
import 'package:sipardy_app/core/common/widgets/sp_button.dart';
import 'package:sipardy_app/core/common/widgets/sp_pin_put.dart';
import 'package:sipardy_app/core/common/widgets/sp_scaffold.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/extensions/build_context_x.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/services/router.dart';
import 'package:sipardy_app/core/utils/ui_utils.dart';

/// The join game page
class JoinGamePage extends StatefulHookWidget {

  /// Default constructor
  const JoinGamePage({ super.key });

  @override
  State<JoinGamePage> createState() => _JoinGamePageState();
}

class _JoinGamePageState extends State<JoinGamePage> {

  late TextEditingController _pinController;

  /// Joins the game with the passed ID
  void _joinGame(String roomId) {
    GameRoomRoute(roomId).pushReplacement(context);
  }

  /// Joins the game by extracting the ID from the pin controller
  void _onJoinGame() {
    final String roomId = _pinController.text;
    _joinGame(roomId);
  }

  @override
  Widget build(BuildContext context) {

    _pinController = useTextEditingController();

    return SPScaffold(
      appBar: const SPAppBar(
        title: 'Raum beitreten',
        backButton: SPAppBarBackButton()
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: SPSpacing.lg,
          left: context.leftPadding + SPSpacing.lg + UIUtils.additionalPaddingForCenteredMaxWidth(context),
          right: context.rightPadding + SPSpacing.lg + UIUtils.additionalPaddingForCenteredMaxWidth(context),
          bottom: context.bottomPaddingOrZeroWhenKeyboard + SPSpacing.lg
        ),
        child: Column(
          children: [
            const SPText(
              text: 'Gib den Raum-Code ein, um der Runde beizutreten.',
              alignment: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: SPColors.white
              )
            ),
            const Gap(SPSpacing.lg),
            SPPinPut(
              controller: _pinController,
              onCompleted: _joinGame
            ),
            const Gap(SPSpacing.lg),
            SPButton(
              onPressed: _onJoinGame,
              title: 'Beitreten'
            )
          ]
        )
      )
    );
  }
}