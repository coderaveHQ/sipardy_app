import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import 'package:sipardy_app/core/common/widgets/sp_app_bar.dart';
import 'package:sipardy_app/core/common/widgets/sp_scaffold.dart';
import 'package:sipardy_app/core/common/widgets/sp_text.dart';
import 'package:sipardy_app/core/extensions/build_context_x.dart';
import 'package:sipardy_app/core/res/theme/colors/sp_colors.dart';
import 'package:sipardy_app/core/res/theme/spacing/sp_spacing.dart';

/// A page for showing instructions on how to play this game
class InstructionPage extends StatelessWidget {

  /// Default constructor
  const InstructionPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      appBar: const SPAppBar(
        title: 'Spielanleitung',
        backButton: SPAppBarBackButton()
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: SPSpacing.lg,
          left: context.leftPadding + SPSpacing.lg,
          right: context.rightPadding + SPSpacing.lg,
          bottom: context.bottomPadding + SPSpacing.lg
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SPText(
              text: 'Hier ist alles was du wissen musst:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: SPColors.white
              )
            ),
            Gap(SPSpacing.xxl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SPText(
                  text: '1. SCHRITT:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: SPColors.white
                  )
                ),
                Gap(SPSpacing.md),
                Expanded(
                  child: SPText(
                    text: 'Wähle eine Karte einer Kategorie. Die Zahl auf der Karte entspricht dem Schwierigkeitsgrad und den damit verbundenen zu gewinnenden Punkte.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: SPColors.white
                    )
                  )
                )
              ]
            ),
            Gap(SPSpacing.lg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SPText(
                  text: '2. SCHRITT:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: SPColors.white
                  )
                ),
                Gap(SPSpacing.md),
                Expanded(
                  child: SPText(
                    text: 'Beantworte die Frage.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: SPColors.white
                    )
                  )
                )
              ]
            ),
            Gap(SPSpacing.lg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SPText(
                  text: '3. SCHRITT:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: SPColors.white
                  )
                ),
                Gap(SPSpacing.md),
                Expanded(
                  child: SPText(
                    text: 'Sieh nach, ob du sie korrekt beantwortet hast.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: SPColors.white
                    )
                  )
                )
              ]
            ),
            Gap(SPSpacing.lg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SPText(
                  text: '[OPTIONAL]:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: SPColors.white
                  )
                ),
                Gap(SPSpacing.md),
                Expanded(
                  child: SPText(
                    text: 'Verteile die Anzahl an gewonnen Punkten als Schlücke oder trinke sie selbst wenn du die Frage falsch bantwortet hast.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: SPColors.white
                    )
                  )
                )
              ]
            )
          ]
        )
      )
    );
  }
}