import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';
import 'package:sipardy_app/core/utils/enums/game_category.dart';
import 'package:sipardy_app/src/features/game_room/presentation/app/game_room_is_syncing_notifier.dart';
import 'package:sipardy_app/src/features/game_room/presentation/widgets/game_room_board_card.dart';
import 'package:sipardy_app/src/models/game_room_question.dart';

/// Widget for the game room board
class GameRoomBoard extends ConsumerWidget {

  /// List of all questions
  final List<GameRoomQuestion> questions;

  /// Callback for when a question is chosen
  final void Function(String) onChooseQuestion;

  /// Indicates if any question is already selected
  final bool isAnyQuestionSelected;

  /// Default constructor
  const GameRoomBoard({
    super.key,
    required this.questions,
    required this.onChooseQuestion,
    required this.isAnyQuestionSelected
  });

  /// List of distinct categories in the passed list of questions ordered by their name
  List<GameCategory> _getCategories(List<GameRoomQuestion> questions) {
    final List<GameCategory> categoriesList = questions.map((GameRoomQuestion question) => question.details.category).toSet().toList();
    categoriesList.sort((GameCategory a, GameCategory b) => a.name.compareTo(b.name));
    return categoriesList;
  }

  /// Returns the questions for the passed category ordered by their points
  List<GameRoomQuestion> _getQuestionsForCategory(List<GameRoomQuestion> questions, GameCategory category) {
    final List<GameRoomQuestion> questionsList = questions.where((GameRoomQuestion question) => question.details.category == category).toList();
    questionsList.sort((GameRoomQuestion a, GameRoomQuestion b) => a.details.points.compareTo(b.details.points));
    return questionsList;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool isSyncing = ref.watch(gameRoomIsSyncingNotifierProvider);

    return Row(
      children: List.generate(11, (int columnIndex) {
        if (columnIndex % 2 == 0) return const Gap(SPSpacing.md);
        return Expanded(
          child: Column(
            children: List.generate(13, (int rowIndex) {
              final GameCategory category = _getCategories(questions)[((columnIndex - 1) / 2).toInt()];
              if (<int>[0, 2, 12].contains(rowIndex)) const Gap(SPSpacing.lg);
              if (rowIndex == 1) return GameRoomBoardCard.category(category: category);
              if (rowIndex % 2 == 0) return const Gap(SPSpacing.md);
              final GameRoomQuestion question = _getQuestionsForCategory(questions, category)[((rowIndex - 3) / 2).toInt()];
              return GameRoomBoardCard.question(
                onPressed: () => onChooseQuestion.call(question.questionId),
                question: question,
                isEnabled: !isSyncing && !isAnyQuestionSelected && question.answer == null
              );
            })
          )
        );
      })
    );
  }
}