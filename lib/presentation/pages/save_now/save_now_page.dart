import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_saving_method.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';

import '../../widgets/custom_app_bar.dart';

class SaveNowPage extends StatefulWidget {
  const SaveNowPage({Key? key}) : super(key: key);

  @override
  State<SaveNowPage> createState() => _SaveNowPageState();
}

class _SaveNowPageState extends State<SaveNowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              color: Colors.white,
              hasBackButton: true,
              body: Text(AppLocalizations.of(context).selectSavingMethod, style: Theme.of(context).textTheme.titleMedium),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultSpacing),
                child: Column(
                  children: [
                    _buildNeoTransfer(),
                    const SizedBox(height: 24),
                    _buildOtherMethods(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeoTransfer() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
        color: ColorValues.warning10,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
              child: Image.asset(
                'assets/save_now/logo_neobank.png',
                width: 62,
                height: 62,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: UiConstant.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).neoBankTransferTitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: ColorValues.warning80, fontSize: 14),
                    ),
                    const SizedBox(height: UiConstant.mediumSpacing),
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context).neoBankTransferDesc1,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12, color: ColorValues.warning80),
                        children: [
                          TextSpan(
                            text: ' ${AppLocalizations.of(context).neoBankTransferDesc2} ',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 12, color: ColorValues.warning80),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context).neoBankTransferDesc3,
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12, color: ColorValues.warning80)
                          )
                        ]
                      )
                    )
                  ],
                ),
              ),
            ),
            const Icon(
              Iconsax.arrow_right_3,
              color: ColorValues.primary90,
              size: 24,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOtherMethods() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UiConstant.sidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).otherMethods,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 16),
          CustomSavingMethod(text: AppLocalizations.of(context).requestBalance, imageUrl: 'assets/activity/img_child_2.png', onTap: () {}),
          const SizedBox(height: UiConstant.defaultSpacing),
          CustomSavingMethod(text: AppLocalizations.of(context).eWallet, imageUrl: 'assets/activity/img_child.png', onTap: () {}),
          const SizedBox(height: UiConstant.defaultSpacing),
          CustomSavingMethod(text: AppLocalizations.of(context).mobileBanking, imageUrl: 'assets/activity/img_child_3.png', onTap: () {}),
        ],
      ),
    );
  }
}
