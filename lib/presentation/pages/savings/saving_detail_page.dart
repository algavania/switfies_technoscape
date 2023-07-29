import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swifties_technoscape/application/common/db_constants.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/application/repositories/repositories.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
import 'package:swifties_technoscape/data/models/saving/saving_model.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_transaction.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class SavingDetailPage extends StatefulWidget {
  final SavingModel saving;
  final int index;
  final void Function(SavingModel, int) setSavingModel;

  const SavingDetailPage({Key? key, required this.saving, required this.index, required this.setSavingModel}) : super(key: key);

  @override
  State<SavingDetailPage> createState() => _SavingDetailPageState();
}

class _SavingDetailPageState extends State<SavingDetailPage> {
  List<TransactionModel> _transactions = [];
  late SavingModel _saving;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final PanelController _panelController = PanelController();
  final ValueNotifier<Widget> _panelContent =
  ValueNotifier(const SizedBox.shrink());
  final ValueNotifier<double> _panelHeight = ValueNotifier(0);
  final TextEditingController _savingController = TextEditingController();
  final TextEditingController _withdrawController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.loaderOverlay.show();
    });
    _saving = widget.saving;
    _getAllData();
    super.initState();
  }

  Future<void> _getAllData() async {
    if (!context.loaderOverlay.visible) {
      context.loaderOverlay.show();
    }
    try {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      _transactions.clear();
      _transactions = await TransactionRepository().getSavingTransactionHistory(limit: 2, savingId: _saving.id!);
      _saving = await SavingRepository().getSavingById(_saving.id!);
      widget.setSavingModel.call(_saving, widget.index);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      SharedCode.showSnackbar(context: context, message: e.toString(), isSuccess: false);
    }
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _getAllData();
          },
          child: ValueListenableBuilder(
              valueListenable: _panelContent,
              builder: (context, _, __) {
                return SlidingUpPanel(
                  controller: _panelController,
                  minHeight: 0,
                  maxHeight: _panelHeight.value,
                  backdropTapClosesPanel: false,
                  color: ColorValues.slidingPanelBackground,
                  backdropEnabled: true,
                  backdropColor: ColorValues.grey90,
                  backdropOpacity: 0.32,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(color: ColorValues.grey50.withOpacity(0))
                  ],
                  panel: Padding(
                    padding: const EdgeInsets.all(UiConstant.sidePadding),
                    child: _panelContent.value,
                  ),
                  body: Column(
                    children: [
                      CustomAppBar(
                        hasBackButton: true,
                        body: Text(
                            AppLocalizations
                                .of(context)
                                .savingTargetDetail,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium
                        ),
                      ),
                      Expanded(child: Stack(
                        children: [
                          ListView(physics: const AlwaysScrollableScrollPhysics()),
                          _isLoading
                              ? Container()
                              :
                          SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  vertical: UiConstant.mediumPadding),
                              child: Column(children: [
                                _buildMainInfo(),
                                const SizedBox(height: UiConstant.defaultSpacing),
                                _buildInfo(
                                  AppLocalizations
                                      .of(context)
                                      .savingTarget,
                                  SharedCode.formatToRupiah(_saving.savingTarget),
                                  Iconsax.status_up5,
                                ),
                                const SizedBox(height: UiConstant.defaultSpacing),
                                _buildInfo(
                                  AppLocalizations
                                      .of(context)
                                      .startSavingDate,
                                  SharedData.monthYearDateFormat.format(
                                      _saving.startDate),
                                  Iconsax.calendar5,
                                ),
                                const SizedBox(height: UiConstant.defaultSpacing),
                                _buildInfo(
                                  AppLocalizations
                                      .of(context)
                                      .endSavingDate,
                                  SharedData.monthYearDateFormat.format(
                                      _saving.endDate),
                                  Iconsax.calendar5,
                                ),
                                if (_saving.hasClaimedReward != null) const SizedBox(
                                    height: UiConstant.defaultSpacing),
                                if (_saving.hasClaimedReward !=
                                    null) _buildClaimReward(),
                                const SizedBox(height: UiConstant.defaultSpacing),
                                _buildHistory(),
                              ])
                          ),
                        ],
                      ))
                    ],
                  ),
                );
              }
          ),
        ),
      ),
    );
  }

  Widget _buildWithdrawPanel() {
    return Form(
      key: _formKey2,
      child: Column(children: [
        GestureDetector(
          onTap: () => _panelController.close(),
          child: Row(children: [
            const Icon(
              Iconsax.arrow_left,
              size: 24,
              color: ColorValues.text50,
            ),
            const SizedBox(width: 16),
            Text(AppLocalizations
                .of(context)
                .withdraw,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 14))
          ]),
        ),
        const SizedBox(height: 24),
        Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _withdrawController,
                    onChanged: (value) {
                      SharedCode.rupiahTextField(value, _withdrawController);
                    },
                    validator: SharedCode.emptyValidators,
                    isRequired: true,
                    label: AppLocalizations
                        .of(context)
                        .amount,
                    hint: AppLocalizations
                        .of(context)
                        .enterAmount,
                    icon: Iconsax.empty_wallet5,
                    textInputType: TextInputType.number,
                  ),
                ],
              ),
            )),
        const SizedBox(height: 24),
        CustomButton(
          buttonText: AppLocalizations
              .of(context)
              .withdraw,
          onPressed: () async {
            if (_formKey2.currentState?.validate() ?? true) {
              context.loaderOverlay.show();
              try {
                double amount = SharedCode.formatFromRupiah(
                    _withdrawController.text)
                    .toDouble();
                SavingModel saving = _saving.copyWith(
                    currentSaving: _saving.currentSaving - amount
                );
                if (saving.currentSaving < 0) throw AppLocalizations
                    .of(context)
                    .insufficientFund;
                await SavingRepository().updateSaving(_saving.id!, saving);
                SharedData.myAccountData.value = SharedData.myAccountData.value
                    ?.copyWith(
                    balance:
                    SharedData.myAccountData.value!.balance + amount);
                TransactionModel transactionModel = TransactionModel(
                    uid: SharedPreferencesService.getUserData()!.uid!,
                    amount: amount,
                    createTime: DateTime.now().millisecondsSinceEpoch,
                    senderAccountNo: SharedData.myAccountData.value!.accountNo,
                    traxType: DbConstants.transferOut,
                    receiverAccountNo: DbConstants.topUpId,
                    senderName: AppLocalizations.of(context).withdraw,
                    receiverName: _saving.title);
                await TransactionRepository().addSavingTransactionHistory(
                    _saving.id!, transactionModel);
                _withdrawController.clear();
                _panelController.close();
                List<TransactionModel> list = [transactionModel];
                list.addAll(_transactions);
                if (list.length > 2) {
                  list.removeRange(2, list.length);
                }
                setState(() {
                  _transactions = list;
                  _saving = saving;
                });
                widget.setSavingModel.call(_saving, widget.index);
                SharedCode.showSnackbar(
                    context: context, message: AppLocalizations
                    .of(context)
                    .withdrawToMainAccount);
              } catch (e) {
                SharedCode.showSnackbar(
                    context: context, message: e.toString(), isSuccess: false);
              }
              context.loaderOverlay.hide();
            }
          },
        ),
      ]),
    );
  }

  Widget _buildDepositPanel() {
    return Form(
      key: _formKey,
      child: Column(children: [
        GestureDetector(
          onTap: () => _panelController.close(),
          child: Row(children: [
            const Icon(
              Iconsax.arrow_left,
              size: 24,
              color: ColorValues.text50,
            ),
            const SizedBox(width: 16),
            Text(AppLocalizations
                .of(context)
                .topup,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 14))
          ]),
        ),
        const SizedBox(height: 24),
        Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _savingController,
                    onChanged: (value) {
                      SharedCode.rupiahTextField(value, _savingController);
                    },
                    validator: SharedCode.emptyValidators,
                    isRequired: true,
                    label: AppLocalizations
                        .of(context)
                        .amount,
                    hint: AppLocalizations
                        .of(context)
                        .enterAmount,
                    icon: Iconsax.empty_wallet5,
                    textInputType: TextInputType.number,
                  ),
                ],
              ),
            )),
        const SizedBox(height: 24),
        CustomButton(
          buttonText: AppLocalizations
              .of(context)
              .topup,
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? true) {
              context.loaderOverlay.show();
              try {
                double amount = SharedCode.formatFromRupiah(
                    _savingController.text)
                    .toDouble();
                if (SharedData.myAccountData.value!.balance - amount <
                    0) throw AppLocalizations
                    .of(context)
                    .insufficientFund;
                SavingModel saving = _saving.copyWith(
                    currentSaving: _saving.currentSaving + amount
                );
                await SavingRepository().updateSaving(_saving.id!, saving);
                SharedData.myAccountData.value = SharedData.myAccountData.value
                    ?.copyWith(
                    balance:
                    SharedData.myAccountData.value!.balance - amount);
                TransactionModel transactionModel = TransactionModel(
                    uid: SharedPreferencesService.getUserData()!.uid!,
                    amount: amount,
                    createTime: DateTime.now().millisecondsSinceEpoch,
                    senderAccountNo: SharedData.myAccountData.value!.accountNo,
                    traxType: DbConstants.transferIn,
                    receiverAccountNo: DbConstants.topUpId,
                    senderName: AppLocalizations.of(context).mainBalance,
                    receiverName: _saving.title);
                await TransactionRepository().addSavingTransactionHistory(
                    _saving.id!, transactionModel);
                List<TransactionModel> list = [transactionModel];
                list.addAll(_transactions);
                if (list.length > 2) {
                  list.removeRange(2, list.length);
                }
                _savingController.clear();
                _panelController.close();
                setState(() {
                  _transactions = list;
                  _saving = saving;
                });
                widget.setSavingModel.call(_saving, widget.index);
                SharedCode.showSnackbar(
                    context: context, message: AppLocalizations
                    .of(context)
                    .depositToSaving);
              } catch (e) {
                SharedCode.showSnackbar(
                    context: context, message: e.toString(), isSuccess: false);
              }
              context.loaderOverlay.hide();
            }
          },
        ),
      ]),
    );
  }

  Widget _buildMainInfo() {
    IconData iconData = Iconsax.more_square5;
    switch (_saving.category) {
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
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          children: [
            Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations
                        .of(context)
                        .savingTarget,
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 12),
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
                          _saving.title,
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _saving.category,
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                              fontSize: 10, color: ColorValues.greyBase),
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
                    AppLocalizations
                        .of(context)
                        .yourSavings,
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('Rp ', style: Theme
                          .of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                          fontSize: 20, color: ColorValues.success30)),
                      Text(SharedCode.formatThousands(_saving.currentSaving),
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                              fontSize: 20, color: ColorValues.success30)),
                      const SizedBox(width: 4),
                      const Icon(Iconsax.trend_up, color: ColorValues.success50,
                          size: 20)
                    ],
                  ),
                ],
              ),
            ]),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: UiConstant.defaultPadding,
                  horizontal: UiConstant.sidePadding),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
                  border: Border.all(width: 1, color: ColorValues.grey10)
              ),
              child: Row(children: [
                Expanded(child: _buildActionButton(
                  AppLocalizations
                      .of(context)
                      .topup,
                  Iconsax.direct_down5,
                      () {
                    _panelContent.value = _buildDepositPanel();
                    _panelHeight.value = 40.h;
                    _panelController.open();
                  },
                )),
                Expanded(child: _buildActionButton(
                  AppLocalizations
                      .of(context)
                      .withdraw,
                  Iconsax.direct_up5,
                      () {
                    _panelContent.value = _buildWithdrawPanel();
                    _panelHeight.value = 40.h;
                    _panelController.open();
                  },
                )),
                Expanded(child: _buildActionButton(
                  AppLocalizations
                      .of(context)
                      .history,
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
    return GestureDetector(
      onTap: onTap,
      child: Column(
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
            style: Theme
                .of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget _buildInfo(String title, String content, IconData iconData) {
    return CustomShadow(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
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
                style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                content,
                style: Theme
                    .of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 12),
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildClaimReward() {
    return CustomShadow(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Row(
          children: [
            const Icon(
              Iconsax.gift5,
              size: 16,
              color: ColorValues.text50,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                AppLocalizations
                    .of(context)
                    .claimReward,
                style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _saving.hasClaimedReward! ? Text(
                AppLocalizations
                    .of(context)
                    .hasClaimReward,
                style: Theme
                    .of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 12),
                textAlign: TextAlign.right,
              ) : CustomButton(
                buttonText: AppLocalizations
                    .of(context)
                    .claim,
                onPressed: _saving.currentSaving >= _saving.savingTarget
                    ? () {}
                    : null,
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
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                  child: Text(
                    AppLocalizations
                        .of(context)
                        .savingHistory,
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge,
                  )),
              if (_transactions.isNotEmpty)
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    AppLocalizations
                        .of(context)
                        .seeAll,
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(
                        fontSize: 12, color: Theme
                        .of(context)
                        .primaryColor),
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
                return CustomTransaction(
                    userId: SharedPreferencesService.getUserData()!.accountNo!,
                    refreshPage: () {},
                    transactionModel: _transactions[i]);
              },
              separatorBuilder: (_, __) {
                return const SizedBox(height: UiConstant.defaultSpacing);
              },
            ) : _buildEmptyHistory(),
            if (_transactions.isNotEmpty) const SizedBox(height: 16),
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
            AppLocalizations
                .of(context)
                .historyEmpty,
            style:
            Theme
                .of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontSize: 14),
          ),
          const SizedBox(height: UiConstant.mediumSpacing),
          Text(
            AppLocalizations
                .of(context)
                .historyEmptyDescription,
            style: Theme
                .of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 12),
          )
        ]),
      ),
    );
  }
}
