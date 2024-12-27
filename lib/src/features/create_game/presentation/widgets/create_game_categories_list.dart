import 'package:flutter/material.dart';

import 'package:sipardy_app/core/common/widgets/sp_chip.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/utils/enums/game_category.dart';

/// A list of categories
class CreateGameCategoriesList extends StatelessWidget {

  /// The categories
  final Map<GameCategory, bool> categories;

  /// Whether the list is enabled
  final bool isEnabled;

  /// The callback when a category is pressed
  final void Function(GameCategory)? onPressed;

  /// Default constructor
  const CreateGameCategoriesList({
    super.key,
    required this.categories,
    this.isEnabled = true,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: SPSpacing.md,
      runSpacing: SPSpacing.md,
      children: categories.entries.map((MapEntry<GameCategory, bool> entry) {
        return SPChip.clickable(
          onPressed: () => onPressed?.call(entry.key),
          title: entry.key.name,
          isEnabled: isEnabled,
          backgroundColor: entry.value ? SPColors.blue500 : SPColors.tertiaryBackground,
          foregroundColor: SPColors.white,
        );
      }).toList()
    );
  }
}