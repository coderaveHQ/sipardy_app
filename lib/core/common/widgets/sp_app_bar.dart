import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:sipardy_app/core/common/widgets/sp_circular_button.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/extensions/build_context_x.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';

/// Custom App Bar widget
class SPAppBar extends StatelessWidget implements PreferredSizeWidget {

  /// Back button
  final SPAppBarBackButton? backButton;

  /// Title
  final String title;

  /// Action buttons
  final List<SPAppBarButton> actionButtons;

  /// Default constructor
  const SPAppBar({ 
    super.key,
    this.backButton,
    this.title = '',
    this.actionButtons = const <SPAppBarButton>[]
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: SPColors.primaryBackground,
      surfaceTintColor: SPColors.primaryBackground,
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      elevation: 0.0,
      title: Padding(
        padding: EdgeInsets.only(
          left: context.leftPadding + SPSpacing.lg,
          right: context.rightPadding + SPSpacing.lg
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (backButton != null) backButton!,
            if (backButton != null && title.isNotEmpty) const Gap(SPSpacing.md),
            Expanded(
              child: SPText(
                text: title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: SPColors.white
                )
              )
            ),
            if (title.isNotEmpty && actionButtons.isNotEmpty) const Gap(SPSpacing.md),
            if (actionButtons.isNotEmpty) Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(actionButtons.length, (int index) {
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0.0 : SPSpacing.md),
                  child: actionButtons[index]
                );
              })
            )
          ]
        )
      )
    );
  }
}

/// Custom App Bar button widget
class SPAppBarButton extends StatelessWidget {

  /// On pressed callback
  final void Function()? onPressed;

  /// Whether the button is loading
  final bool isLoading;

  /// Wether the button is enabled
  final bool isEnabled;

  /// Icon
  final IconData icon;

  /// Default constructor
  const SPAppBarButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return SPCircularButton(
      onPressed: onPressed,
      size: kToolbarHeight - 8.0,
      isLoading: isLoading,
      isEnabled: isEnabled,
      backgroundColor: SPColors.primaryButtonBackground,
      foregroundColor: SPColors.white,
      icon: icon
    );
  }
}

/// Custom App Bar back button widget
class SPAppBarBackButton extends StatelessWidget {

  /// On pressed callback
  final bool Function()? onPressed;

  /// Whether the button is loading
  final bool isLoading;

  /// Wether the button is enabled
  final bool isEnabled;

  /// Default constructor
  const SPAppBarBackButton({ 
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true
  });

  /// On pressed callback with a check weather the action should be called
  void _onPressed(BuildContext context) {
    if (!isLoading && isEnabled) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isEnabled && !isLoading,
      child: SPAppBarButton(
        onPressed: () => _onPressed(context),
        isLoading: isLoading,
        isEnabled: isEnabled,
        icon: LucideIcons.arrowLeft
      )
    );
  }
}