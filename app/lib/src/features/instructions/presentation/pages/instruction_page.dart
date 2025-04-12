import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sipardy_app/core/res/localization/custom_localization.dart';
import 'package:sipardy_app/core/res/localization/language/custom_language_data.dart';
import 'package:sipardy_app/core/common/widgets/sp_text_button.dart';
import 'package:sipardy_app/core/error/launch_error.dart';
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

  String get _supportUrl => 'https://coderavehq.github.io/sipardy_app/support.html';

  String get _privacyPolicyUrl => 'https://coderavehq.github.io/sipardy_app/privacy-policy.html';

  /// Opens the privacy policy page in the default browser
  Future<void> _openPrivacyPolicy(BuildContext context) async {
    final Uri url = Uri.parse(_privacyPolicyUrl);
    final bool opened = await launchUrl(url);
    if (!opened && context.mounted) LaunchError.urlNotOpened().showToast(context);
  }

  /// Opens the support page in the default browser
  Future<void> _openSupport(BuildContext context) async {
    final Uri url = Uri.parse(_supportUrl);
    final bool opened = await launchUrl(url);
    if (!opened && context.mounted) LaunchError.urlNotOpened().showToast(context);
  }

  @override
  Widget build(BuildContext context) {

    final CustomLanguageData language = CustomLocalization.of(context).language;

    return SPScaffold(
      appBar: SPAppBar(
        title: language.instructionsAppBarTitle,
        backButton: const SPAppBarBackButton()
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: SPSpacing.lg,
          left: context.leftPadding + SPSpacing.lg,
          right: context.rightPadding + SPSpacing.lg,
          bottom: context.bottomPadding + SPSpacing.lg
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SPText(
              text: language.instructionsOverview,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: SPColors.white
              )
            ),
            const Gap(SPSpacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SPText(
                  text: language.instructionsStep1Title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: SPColors.white
                  )
                ),
                const Gap(SPSpacing.md),
                Expanded(
                  child: SPText(
                    text: language.instructionsStep1Description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: SPColors.white
                    )
                  )
                )
              ]
            ),
            const Gap(SPSpacing.lg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SPText(
                  text: language.instructionsStep2Title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: SPColors.white
                  )
                ),
                const Gap(SPSpacing.md),
                Expanded(
                  child: SPText(
                    text: language.instructionsStep2Description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: SPColors.white
                    )
                  )
                )
              ]
            ),
            const Gap(SPSpacing.lg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SPText(
                  text: language.instructionsStep3Title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: SPColors.white
                  )
                ),
                const Gap(SPSpacing.md),
                Expanded(
                  child: SPText(
                    text: language.instructionsStep3Description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: SPColors.white
                    )
                  )
                )
              ]
            ),
            const Gap(SPSpacing.lg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SPText(
                  text: language.instructionsOptionalTitle,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: SPColors.white
                  )
                ),
                const Gap(SPSpacing.md),
                Expanded(
                  child: SPText(
                    text: language.instructionsOptionalDescription,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: SPColors.white
                    )
                  )
                )
              ]
            ),
            const Gap(SPSpacing.xxl),
            SPText(
              text: language.instructionsPrivacyPolicy,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: SPColors.white
              )
            ),
            const Gap(SPSpacing.xl),
            SPTextButton(
              onTap: () => _openPrivacyPolicy(context),
              text: _privacyPolicyUrl
            ),
            const Gap(SPSpacing.xxl),
            SPText(
              text: language.instructionsSupport,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: SPColors.white
              )
            ),
            const Gap(SPSpacing.xl),
            SPTextButton(
              onTap: () => _openSupport(context),
              text: _supportUrl
            )
          ]
        )
      )
    );
  }
}