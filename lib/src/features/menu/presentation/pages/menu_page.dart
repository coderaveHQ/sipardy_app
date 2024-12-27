import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:sipardy_app/core/common/widgets/sp_button.dart';
import 'package:sipardy_app/core/common/widgets/sp_scaffold.dart';
import 'package:sipardy_app/core/extensions/build_context_x.dart';
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: context.topPadding + SPSpacing.lg,
          left: context.leftPadding + SPSpacing.lg,
          right: context.rightPadding + SPSpacing.lg,
          bottom: context.bottomPaddingOrKeyboard + SPSpacing.lg
        ),
        child: Column(
          children: [
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