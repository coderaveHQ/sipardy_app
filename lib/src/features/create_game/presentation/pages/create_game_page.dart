import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sipardy_app/core/common/widgets/sp_app_bar.dart';
import 'package:sipardy_app/core/common/widgets/sp_button.dart';
import 'package:sipardy_app/core/common/widgets/sp_scaffold.dart';
import 'package:sipardy_app/core/common/widgets/sp_square_button.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/common/widgets/sp_text_field.dart';
import 'package:sipardy_app/core/extensions/build_context_x.dart';
import 'package:sipardy_app/core/extensions/object_x.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/services/router.dart';
import 'package:sipardy_app/core/services/toaster.dart';
import 'package:sipardy_app/core/utils/enums/game_category.dart';
import 'package:sipardy_app/src/features/create_game/presentation/app/create_game_page_state_notifier.dart';
import 'package:sipardy_app/src/features/create_game/presentation/widgets/create_game_categories_list.dart';
import 'package:sipardy_app/src/features/create_game/presentation/widgets/create_game_players_list.dart';

/// The create game page
class CreateGamePage extends StatefulHookConsumerWidget {

  /// Default constructor
  const CreateGamePage({ super.key });

  @override
  ConsumerState<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends ConsumerState<CreateGamePage> {

  late TextEditingController _playerNamesController;

  /// Creates a new game room
  Future<void> _onCreateGame() async {
    final String? gameRoomId = await ref.read(createGamePageStateNotifierProvider.notifier).createGameRoom();
    if (gameRoomId != null && mounted) {
      GameRoomRoute(gameRoomId).pushReplacement(context);
      Toaster.showSuccess(context, 'Raum erstellt! Du kannst nun den Raum-Code teilen.');
    }
  }

  /// Triggers the selected category
  void _onTriggerCategory(GameCategory category) {
    ref.read(createGamePageStateNotifierProvider.notifier).triggerCategory(category);
  }

  /// Adds a new player
  void _onNewPlayer() {
    final String playerName = _playerNamesController.text.trim();
    if (playerName.isEmpty) return;
    ref.read(createGamePageStateNotifierProvider.notifier).addPlayerName(playerName);
    _playerNamesController.clear();
  }

  /// Deletes a player
  void _onDeletePlayer(int index) {
    ref.read(createGamePageStateNotifierProvider.notifier).removePlayerName(index);
  }

  /// Resets all players by removing them
  void _onResetPlayers() {
    ref.read(createGamePageStateNotifierProvider.notifier).resetPlayerNames();
  }

  /// Handles error cases by showing a toast
  void _handleCreateGamePageStateUpdate(CreateGamePageState? last, CreateGamePageState next) {
    if (next.error != null) next.error!.showErrorToast(context);
  }

  @override
  Widget build(BuildContext context) {

    _playerNamesController = useTextEditingController();

    final CreateGamePageState pageState = ref.watch(createGamePageStateNotifierProvider);

    ref.listen(createGamePageStateNotifierProvider, _handleCreateGamePageStateUpdate);

    return SPScaffold(
      appBar: SPAppBar(
        title: 'Raum erstellen',
        backButton: SPAppBarBackButton(isEnabled: !pageState.isCreatingGame)
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: SPSpacing.lg,
          left: context.leftPadding + SPSpacing.lg,
          right: context.rightPadding + SPSpacing.lg,
          bottom: context.bottomPaddingOrZeroWhenKeyboard + SPSpacing.lg
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SPText(
              text: '1. Füge Spieler*innen hinzu.',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: SPColors.white
              )
            ),
            const Gap(SPSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: SPTextField(
                    controller: _playerNamesController,
                    icon: LucideIcons.tag,
                    hint: 'Spielername',
                    isEnabled: !pageState.isCreatingGame
                  )
                ),
                const Gap(SPSpacing.sm),
                SPSquareButton(
                  onPressed: _onNewPlayer,
                  icon: LucideIcons.plus,
                  isEnabled: !pageState.isCreatingGame
                ),
                const Gap(SPSpacing.sm),
                SPSquareButton(
                  onPressed: _onResetPlayers,
                  icon: LucideIcons.rotateCw,
                  isEnabled: !pageState.isCreatingGame
                )
              ]
            ),
            const Gap(SPSpacing.lg),
            CreateGamePlayersList(
              onPressed: _onDeletePlayer,
              playerNames: pageState.playerNames,
              isEnabled: !pageState.isCreatingGame
            ),
            const Gap(SPSpacing.xl),
            const SPText(
              text: '2. Wähle 5 Kategorien.',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: SPColors.white
              )
            ),
            const Gap(SPSpacing.xl),
            CreateGameCategoriesList(
              onPressed: _onTriggerCategory,
              categories: pageState.categories,
              isEnabled: !pageState.isCreatingGame
            ),
            const Gap(SPSpacing.xl),
            const SPText(
              text: '3. Starte das Spiel.',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: SPColors.white
              )
            ),
            const Gap(SPSpacing.xl),
            SPButton(
              onPressed: _onCreateGame,
              title: 'Erstellen',
              isEnabled: !pageState.isCreatingGame,
              isLoading: pageState.isCreatingGame
            )
          ]
        )
      )
    );
  }
}