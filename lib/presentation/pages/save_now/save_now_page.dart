import 'package:flutter/material.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_saving_method.dart';

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
                child: Padding(
                  padding: const EdgeInsets.all(UiConstant.defaultPadding),
                  child: Column(
                    children: [
                      CustomSavingMethod(text: AppLocalizations.of(context).requestBalance, imageUrl: 'assets/activity/img_child_2.png', onTap: () {}),
                      const SizedBox(height: UiConstant.defaultSpacing),
                      CustomSavingMethod(text: AppLocalizations.of(context).topUp, imageUrl: 'assets/activity/img_child.png', onTap: () {}),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
