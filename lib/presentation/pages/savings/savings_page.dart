import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swifties_technoscape/data/models/saving/saving_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_saving.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_saving_balance.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';

class SavingsPage extends StatefulWidget {
  const SavingsPage({Key? key}) : super(key: key);

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  final SavingModel _dummySaving1 = SavingModel(title: 'Beli Laptop', category: 'Pendidikan', currentSaving: 120000, savingTarget: 12000000, startDate: DateTime.now(), endDate: DateTime.now());
  final SavingModel _dummySaving2 = SavingModel(title: 'Beli PS5', category: 'Hiburan', currentSaving: 164000, savingTarget: 8400000, startDate: DateTime.now(), endDate: DateTime.now());
  final SavingModel _dummySaving3 = SavingModel(title: 'Beli S500', category: 'Kendaraan', currentSaving: 600000000, savingTarget: 6000000000, startDate: DateTime.now(), endDate: DateTime.now());
  List<SavingModel> _savings = [];

  @override
  void initState() {
    _savings = [_dummySaving1, _dummySaving2, _dummySaving3];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              color: Colors.white,
              hasBackButton: true,
              body: Text(AppLocalizations.of(context).createSavingTarget, style: Theme.of(context).textTheme.titleMedium),
            ),
            Expanded(child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultSpacing),
              child: Column(children: [
                const CustomSavingBalance(balance: 2200000),
                const SizedBox(height: UiConstant.defaultSpacing),
                _buildAddSaving(),
                const SizedBox(height: UiConstant.defaultSpacing),
                _buildSavings(),
              ]),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildAddSaving() {
    return CustomShadow(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: UiConstant.defaultPadding,
              horizontal: UiConstant.sidePadding),
          color: ColorValues.primary10,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
                child: Image.asset(
                  'assets/activity/img_child.png',
                  width: 62,
                  height: 62,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: UiConstant.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations
                            .of(context)
                            .createNewTargetTitle,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                            color: ColorValues.primary80, fontSize: 14),
                      ),
                      const SizedBox(height: UiConstant.mediumSpacing),
                      Text(
                        AppLocalizations
                            .of(context)
                            .createNewTargetDescription,
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 12),
                      ),
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
      ),
    );
  }

  Widget _buildSavings() {
    return CustomShadow(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).createNewTargetTitle,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _savings.length,
              itemBuilder: (context, index) {
                return CustomSaving(savingModel: _savings[index]);
              },
              separatorBuilder: (_, __) {
                return const SizedBox(height: UiConstant.defaultSpacing);
              },
            ),
          ],
        ),
      ),
    );
  }
}
