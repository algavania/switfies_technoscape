import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/data/models/saving/saving_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';

class CustomSaving extends StatelessWidget {
  final SavingModel savingModel;

  const CustomSaving({Key? key, required this.savingModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData = Iconsax.more_square5;
    switch (savingModel.category) {
      case 'Pendidikan':
        iconData = Iconsax.teacher5;
        break;
      case 'Hiburan':
        iconData = Iconsax.game5;
        break;
      case 'Kendaraan':
        iconData = Iconsax.car5;
        break;
    }

    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(UiConstant.defaultPadding),
      decoration: BoxDecoration(
          color: ColorValues.surface,
          borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
          border: Border.all(color: ColorValues.grey10, width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: ColorValues.primary10,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                iconData,
                size: 24,
                color: ColorValues.primary50,
              ),
            ),
            const SizedBox(width: UiConstant.mediumSpacing),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  savingModel.title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  savingModel.category,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 10, color: ColorValues.greyBase),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppLocalizations.of(context).currentSavings,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 10, color: ColorValues.greyBase),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('Rp ', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 14, color: ColorValues.success30)),
                    Text(SharedCode.formatThousands(savingModel.currentSaving), style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 14, color: ColorValues.success30)),
                    const SizedBox(width: 4),
                    const Icon(Iconsax.trend_up, color: ColorValues.success50, size: 16)
                  ],
                ),
              ],
            ),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Text(
              AppLocalizations.of(context).target,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
            ),
            const Spacer(),
            Text(
              SharedCode.formatToRupiah(savingModel.savingTarget),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12),
            ),
          ]),
          const SizedBox(height: 4),
          Row(children: [
            Text(
              '${AppLocalizations.of(context).from} ',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
            ),
            Text(
              SharedData.monthYearDateFormat.format(savingModel.startDate),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12),
            ),
            const Expanded(child: Center(child: Icon(
              Iconsax.arrow_right_1,
              size: 16,
              color: ColorValues.text50,
            ))),
            Text(
              '${AppLocalizations.of(context).until} ',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
            ),
            Text(
              SharedData.monthYearDateFormat.format(savingModel.endDate),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12),
            ),
          ]),
        ],
      ),
    );
  }
}
