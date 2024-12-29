import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sipardy_app/core/common/widgets/sp_app_bar.dart';

import 'package:sipardy_app/core/common/widgets/sp_button.dart';
import 'package:sipardy_app/core/common/widgets/sp_scaffold.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/extensions/build_context_x.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/services/router.dart';

/// The menu page
class MenuPage extends StatefulWidget {

  /// Default constructor
  const MenuPage({ super.key });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  /// Navigates to the instructions page
  Future<void> _onInstructions() async {
    await const InstructionsRoute().push(context);
  }

  /// Navigates to the create game route
  Future<void> _onCreateGame() async {
    await const CreateGameRoute().push(context);
  }

  /// Navigates to the join game route
  Future<void> _onJoinGame() async {
    await const JoinGameRoute().push(context);
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      appBar: SPAppBar(
        title: 'Spielmenü',
        actionButtons: [
          SPAppBarButton(
            onPressed: _onInstructions,
            icon: LucideIcons.circleHelp
          )
        ]
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: context.topPadding + SPSpacing.lg,
          left: context.leftPadding + SPSpacing.lg,
          right: context.rightPadding + SPSpacing.lg,
          bottom: context.bottomPaddingOrKeyboard + SPSpacing.lg
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: context.screenWidth / 2.5,
              height: context.screenWidth / 2.5
            ),
            const Gap(SPSpacing.lg),
            const SPText(
              text: 'TAKE A SIP',
              alignment: TextAlign.center,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w900,
                color: SPColors.white,
                fontStyle: FontStyle.italic
              )
            ),
            const Gap(SPSpacing.xxl),
            const SPText(
              text: 'Wähle aus, ob du ein neues Spiel erstellen- oder einem bestehenden beitreten willst.',
              alignment: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: SPColors.white
              )
            ),
            const Gap(SPSpacing.lg),
            SPButton(
              onPressed: _onCreateGame,
              title: 'Erstellen'
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