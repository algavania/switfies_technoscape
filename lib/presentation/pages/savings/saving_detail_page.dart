import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/application/common/db_constants.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/data/models/saving/saving_model.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_transaction.dart';

class SavingDetailPage extends StatefulWidget {
  final SavingModel saving;

  const SavingDetailPage({Key? key, required this.saving}) : super(key: key);

  @override
  State<SavingDetailPage> createState() => _SavingDetailPageState();
}

class _SavingDetailPageState extends State<SavingDetailPage> {
  final List<TransactionModel> _transactions = [];

  @override
  void initState() {
    _transactions.add(TransactionModel(uid: 0, amount: 100000, createTime: 1690612454776, senderAccountNo: DbConstants.topUpId, traxType: 'Transfer In', receiverAccountNo: '', senderName: 'Minta Saldo', receiverName: widget.saving.title, isApproved: true));

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              hasBackButton: true,
              body: Text(
                AppLocalizations.of(context).savingTargetDetail,
                style: Theme.of(context).textTheme.titleMedium
              ),
            ),
            Expanded(child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: UiConstant.mediumPadding),
              child: Column(children: [
                _buildMainInfo(),
                const SizedBox(height: UiConstant.defaultSpacing),
                _buildInfo(
                  AppLocalizations.of(context).savingTarget,
                  SharedCode.formatToRupiah(widget.saving.savingTarget),
                  Iconsax.status_up5,
                ),
                const SizedBox(height: UiConstant.defaultSpacing),
                _buildInfo(
                  AppLocalizations.of(context).startSavingDate,
                  SharedData.monthYearDateFormat.format(widget.saving.startDate),
                  Iconsax.calendar5,
                ),
                const SizedBox(height: UiConstant.defaultSpacing),
                _buildInfo(
                  AppLocalizations.of(context).endSavingDate,
                  SharedData.monthYearDateFormat.format(widget.saving.endDate),
                  Iconsax.calendar5,
                ),
                const SizedBox(height: UiConstant.defaultSpacing),
                _buildHistory(),
              ])
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildMainInfo() {
    IconData iconData = Iconsax.more_square5;
    switch (widget.saving.category) {
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

    return CustomShadow(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          children: [
            Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).savingTarget,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 8),
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
                          widget.saving.title,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.saving.category,
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 10, color: ColorValues.greyBase),
                        ),
                      ],
                    ),
                  ])
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppLocalizations.of(context).yourSavings,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('Rp ', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20, color: ColorValues.success30)),
                      Text(SharedCode.formatThousands(widget.saving.currentSaving), style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20, color: ColorValues.success30)),
                      const SizedBox(width: 4),
                      const Icon(Iconsax.trend_up, color: ColorValues.success50, size: 20)
                    ],
                  ),
                ],
              ),
            ]),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
                border: Border.all(width: 1, color: ColorValues.grey10)
              ),
              child: Row(children: [
                Expanded(child: _buildActionButton(
                  AppLocalizations.of(context).topup,
                  Iconsax.direct_down5,
                  () {},
                )),
                Expanded(child: _buildActionButton(
                  AppLocalizations.of(context).transferOut,
                  Iconsax.direct_up5,
                  () {},
                )),
                Expanded(child: _buildActionButton(
                  AppLocalizations.of(context).history,
                  Iconsax.activity5,
                  () {},
                )),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, IconData iconData, Function() onTap) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorValues.primary10,
          ),
          child: Icon(
            iconData,
            size: 24,
            color: ColorValues.primary50,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _buildInfo(String title, String content, IconData iconData) {
    return CustomShadow(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Row(
          children: [
            Icon(
              iconData,
              size: 16,
              color: ColorValues.text50,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                content,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12),
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Widget _buildHistory() {
    return CustomShadow(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                  child: Text(
                    AppLocalizations.of(context).savingHistory,
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
              if (_transactions.isNotEmpty)
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    AppLocalizations.of(context).seeAll,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 12, color: Theme.of(context).primaryColor),
                  ),
                )
            ]),
            const SizedBox(height: 16),
            _transactions.isNotEmpty ? ListView.separated(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _transactions.length,
              itemBuilder: (c, i) {
                return CustomTransaction(transactionModel: _transactions[i]);
              },
              separatorBuilder: (_, __) {
                return const SizedBox(height: UiConstant.defaultSpacing);
              },
            ) : _buildEmptyHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyHistory() {
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(children: [
          Text(
            AppLocalizations.of(context).historyEmpty,
            style:
            Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14),
          ),
          const SizedBox(height: UiConstant.mediumSpacing),
          Text(
            AppLocalizations.of(context).historyEmptyDescription,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 12),
          )
        ]),
      ),
    );
  }
}
