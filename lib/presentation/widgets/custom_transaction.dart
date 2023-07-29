import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/application/common/db_constants.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_button.dart';

class CustomTransaction extends StatelessWidget {
  final TransactionModel transactionModel;
  final bool isNotification;

  const CustomTransaction({Key? key, required this.transactionModel, this.isNotification = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String traxType = AppLocalizations.of(context).topup;
    IconData iconData = Iconsax.direct_down5;
    Color backgroundColor = ColorValues.primary10;
    Color iconColor = ColorValues.primary50;

    if (transactionModel.traxType == DbConstants.transferIn) {
      if (transactionModel.senderAccountNo != DbConstants.topUpId) {
        traxType = AppLocalizations.of(context).transferIn;
        iconData = Iconsax.direct_inbox5;
        backgroundColor = ColorValues.success10;
        iconColor = ColorValues.success30;
      }
    } else {
      traxType = AppLocalizations.of(context).transferOut;
      iconData = Iconsax.direct_up5;
      backgroundColor = ColorValues.danger10;
      iconColor = ColorValues.danger30;
    }


    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(UiConstant.defaultPadding),
      decoration: BoxDecoration(
          color: ColorValues.surface,
          borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
          border: Border.all(color: ColorValues.grey10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                SharedData.dateFormat.format(DateTime.fromMillisecondsSinceEpoch(transactionModel.createTime)),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12, color: ColorValues.greyBase),
              ),
              const Spacer(),
              if (transactionModel.relatedId != null && isNotification) Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    width: 0.5,
                    color: transactionModel.isApproved == null ? ColorValues.warning30 : (transactionModel.isApproved! ? ColorValues.success30 : ColorValues.danger30),
                  ),
                  color: transactionModel.isApproved == null ? ColorValues.warning10.withOpacity(0.8) : (transactionModel.isApproved! ? ColorValues.success10 : ColorValues.danger10),
                ),
                child: Text(
                  transactionModel.isApproved == null ? AppLocalizations.of(context).waiting : (transactionModel.isApproved! ? AppLocalizations.of(context).approved : AppLocalizations.of(context).rejected),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 10,
                    color: transactionModel.isApproved == null ? ColorValues.warning30 : (transactionModel.isApproved! ? ColorValues.success30 : ColorValues.danger30),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  iconData,
                  size: 24,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: UiConstant.mediumSpacing),
              Text(
                traxType,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
              Text(
                traxType == AppLocalizations.of(context).transferOut
                    ? '-${SharedCode.formatToRupiah(transactionModel.amount)}'
                    : '+${SharedCode.formatToRupiah(transactionModel.amount)}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 12,
                  color: traxType == AppLocalizations.of(context).transferOut
                      ? ColorValues.danger30
                      : ColorValues.success30,
                ),
              ),
            ]),
          ),
          Row(children: [
            Text(
              '${AppLocalizations.of(context).from} ',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
            ),
            Text(
              transactionModel.senderName,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12),
            ),
            const Expanded(child: Center(child: Icon(
              Iconsax.arrow_right_1,
              size: 16,
              color: ColorValues.text50,
            ))),
            Text(
              '${AppLocalizations.of(context).to} ',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
            ),
            Text(
              transactionModel.receiverName,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12),
            ),
          ]),
          if (transactionModel.relatedId == null) Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(children: [
              Expanded(child: CustomButton(
                buttonText: AppLocalizations.of(context).reject,
                height: 36,
                fontSize: 12,
                backgroundColor: ColorValues.danger30,
                borderRadius: 8,
                onPressed: () {},
              )),
              const SizedBox(width: 6),
              Expanded(child: CustomButton(
                buttonText: AppLocalizations.of(context).approve,
                height: 36,
                fontSize: 12,
                backgroundColor: ColorValues.success30,
                borderRadius: 8,
                onPressed: () {},
              )),
            ]),
          ),
        ],
      ),
    );
  }
}
