import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/application/common/db_constants.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/application/repositories/repositories.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';
import 'package:swifties_technoscape/data/models/user/user_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_button.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../data/models/token/token_model.dart';

class CustomTransaction extends StatefulWidget {
  final TransactionModel transactionModel;
  final void Function()? refreshPage;
  final bool isNotification;
  final String userId;

  const CustomTransaction({Key? key, required this.transactionModel, this.refreshPage, this.isNotification = false, required this.userId}) : super(key: key);

  @override
  State<CustomTransaction> createState() => _CustomTransactionState();
}

class _CustomTransactionState extends State<CustomTransaction> {
  late TransactionModel _transactionModel;

  @override
  void initState() {
    _transactionModel = widget.transactionModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String traxType = AppLocalizations.of(context).topup;
    IconData iconData = Iconsax.direct_down5;
    Color backgroundColor = ColorValues.primary10;
    Color iconColor = ColorValues.primary50;

    traxType = AppLocalizations.of(context).transferOut;
    iconData = Iconsax.direct_inbox5;
    backgroundColor = ColorValues.success10;
    iconColor = ColorValues.success30;

    debugPrint('testing ${_transactionModel.toJson()}');

    if (_transactionModel.traxType == 'Transfer In' &&
        _transactionModel.senderAccountNo == DbConstants.topUpId) {
      traxType = AppLocalizations.of(context).topup;
    }

    if (_transactionModel.traxType == 'Transfer Out' &&
        _transactionModel.senderAccountNo != DbConstants.topUpId) {
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
          border: Border.all(color: ColorValues.grey10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (_transactionModel.createTime != null) Text(
                SharedData.dateFormat.format(DateTime.fromMillisecondsSinceEpoch(_transactionModel.createTime!)),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12, color: ColorValues.greyBase),
              ),
              const Spacer(),
              if (_transactionModel.relatedId != null && widget.isNotification) Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    width: 0.5,
                    color: _transactionModel.isApproved == null ? ColorValues.warning30 : (_transactionModel.isApproved! ? ColorValues.success30 : ColorValues.danger30),
                  ),
                  color: _transactionModel.isApproved == null ? ColorValues.warning10.withOpacity(0.8) : (_transactionModel.isApproved! ? ColorValues.success10 : ColorValues.danger10),
                ),
                child: Text(
                  _transactionModel.isApproved == null ? AppLocalizations.of(context).waiting : (_transactionModel.isApproved! ? AppLocalizations.of(context).approved : AppLocalizations.of(context).rejected),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 10,
                    color: _transactionModel.isApproved == null ? ColorValues.warning30 : (_transactionModel.isApproved! ? ColorValues.success30 : ColorValues.danger30),
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
                traxType == AppLocalizations.of(context).transferOut && _transactionModel.senderAccountNo == widget.userId
                    ? '-${SharedCode.formatToRupiah(_transactionModel.amount)}'
                    : '+${SharedCode.formatToRupiah(_transactionModel.amount)}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 12,
                      color:
                      traxType == AppLocalizations.of(context).transferOut && _transactionModel.senderAccountNo == widget.userId
                              ? ColorValues.danger30
                              : ColorValues.success30,
                    ),
              ),
            ]),
          ),
          Row(children: [
            Text(
              '${AppLocalizations.of(context).from} ',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 12),
            ),
            Text(
              _transactionModel.senderName ?? _transactionModel.senderAccountNo,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontSize: 12),
            ),
            const Expanded(
                child: Center(
                    child: Icon(
              Iconsax.arrow_right_1,
              size: 16,
              color: ColorValues.text50,
            ))),
            Text(
              '${AppLocalizations.of(context).to} ',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 12),
            ),
            Text(
              _transactionModel.receiverName ??
                  _transactionModel.receiverAccountNo,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontSize: 12),
            ),
          ]),
          if (_transactionModel.relatedId != null && _transactionModel.isApproved == null && SharedPreferencesService.getUserData()!.relatedId == null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(children: [
                Expanded(
                    child: CustomButton(
                  buttonText: AppLocalizations.of(context).reject,
                  height: 36,
                  fontSize: 12,
                  backgroundColor: ColorValues.danger30,
                  borderRadius: 8,
                  onPressed: () async {
                    SharedCode.showAlertDialog(
                        context: context,
                        title: AppLocalizations.of(context).confirmation,
                        description: AppLocalizations.of(context)
                            .denyConfirmationDescription,
                        proceedText: AppLocalizations.of(context).yes,
                        proceedAction: () async {
                          context.loaderOverlay.show();
                          try {
                            _transactionModel =
                                _transactionModel.copyWith(isApproved: false);
                            await TransactionRepository()
                                .updateRequestedTransaction(
                                    _transactionModel.id!, _transactionModel);
                            SharedCode.showSnackbar(
                                context: context,
                                message:
                                    AppLocalizations.of(context).denySuccess);
                            widget.refreshPage?.call();
                          } catch (e) {
                            SharedCode.showSnackbar(
                                context: context,
                                message: e.toString(),
                                isSuccess: false);
                          }
                          context.loaderOverlay.show();
                        });
                  },
                )),
                const SizedBox(width: 6),
                Expanded(
                    child: CustomButton(
                  buttonText: AppLocalizations.of(context).approve,
                  height: 36,
                  fontSize: 12,
                  backgroundColor: ColorValues.success30,
                  borderRadius: 8,
                  onPressed: () {
                    SharedCode.showAlertDialog(
                        context: context,
                        title: AppLocalizations.of(context).confirmation,
                        description: AppLocalizations.of(context)
                            .acceptConfirmationDescription,
                        proceedText: AppLocalizations.of(context).yes,
                        proceedAction: () async {
                          context.loaderOverlay.show();
                          try {
                            _transactionModel =
                                _transactionModel.copyWith(isApproved: true);
                            double amount = _transactionModel.amount;
                            String senderAccountNo = _transactionModel.senderAccountNo;
                            String receiverAccountNo = _transactionModel.receiverAccountNo;
                            UserModel userModel = await UserRepository().getUserByAccountNo(senderAccountNo);
                            TokenModel token = await AuthRepository().generateToken(userModel.username, userModel.loginPassword);
                            await BankRepository().createTransaction(senderAccountNo, receiverAccountNo, amount, token.accessToken);
                            await TransactionRepository()
                                .updateRequestedTransaction(
                                _transactionModel.id!, _transactionModel);
                            SharedCode.showSnackbar(
                                context: context,
                                message:
                                AppLocalizations.of(context).acceptSuccess);
                            widget.refreshPage?.call();
                          } catch (e) {
                            SharedCode.showSnackbar(
                                context: context,
                                message: e.toString(),
                                isSuccess: false);
                          }
                          context.loaderOverlay.show();
                        });

                  },
                )),
              ]),
            )
        ],
      ),
    );
  }
}
