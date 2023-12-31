import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swifties_technoscape/application/common/db_constants.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/application/repositories/repositories.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_button.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_saving_method.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_text_field.dart';

import '../../../data/models/user/user_model.dart';
import '../../core/shared_data.dart';
import '../../widgets/custom_app_bar.dart';

class SaveNowPage extends StatefulWidget {
  const SaveNowPage({Key? key}) : super(key: key);

  @override
  State<SaveNowPage> createState() => _SaveNowPageState();
}

class _SaveNowPageState extends State<SaveNowPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final PanelController _panelController = PanelController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _topUpController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final ValueNotifier<Widget> _panelContent =
      ValueNotifier(const SizedBox.shrink());
  final ValueNotifier<double> _panelHeight = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      color: Colors.white,
                      hasBackButton: true,
                      body: Text(
                          AppLocalizations.of(context).selectSavingMethod,
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: UiConstant.defaultSpacing),
                        child: Column(
                          children: [
                            // _buildNeoTransfer(),
                            // const SizedBox(height: 24),
                            _buildOtherMethods(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _buildNeoTransfer() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: UiConstant.defaultPadding),
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
                            text: AppLocalizations.of(context)
                                .neoBankTransferDesc1,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                    fontSize: 12, color: ColorValues.warning80),
                            children: [
                          TextSpan(
                            text:
                                ' ${AppLocalizations.of(context).neoBankTransferDesc2} ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontSize: 12, color: ColorValues.warning80),
                          ),
                          TextSpan(
                              text: AppLocalizations.of(context)
                                  .neoBankTransferDesc3,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                      fontSize: 12,
                                      color: ColorValues.warning80))
                        ]))
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
          // Text(
          //   AppLocalizations.of(context).otherMethods,
          //   style: Theme.of(context).textTheme.labelLarge,
          // ),
          const SizedBox(height: 16),
          // CustomSavingMethod(
          //     text: AppLocalizations.of(context).requestBalance,
          //     imageUrl: 'assets/activity/img_child_2.png',
          //     onTap: () {
          //       _panelContent.value = _buildRequestBalancePanel();
          //       _panelHeight.value = 90.h;
          //       _panelController.open();
          //     }),
          // const SizedBox(height: UiConstant.defaultSpacing),
          CustomSavingMethod(
              text: AppLocalizations.of(context).topUp,
              imageUrl: 'assets/activity/img_child.png',
              onTap: () {
                _panelContent.value = _buildTopUpPanel();
                _panelHeight.value = 40.h;
                _panelController.open();
              }),
        ],
      ),
    );
  }

  Widget _buildTopUpPanel() {
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
            Text(AppLocalizations.of(context).topUp,
                style: Theme.of(context)
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
                controller: _topUpController,
                onChanged: (value) {
                  SharedCode.rupiahTextField(value, _topUpController);
                },
                validator: SharedCode.emptyValidators,
                isRequired: true,
                label: AppLocalizations.of(context).amount,
                hint: AppLocalizations.of(context).enterAmount,
                icon: Iconsax.empty_wallet5,
                textInputType: TextInputType.number,
              ),
            ],
          ),
        )),
        const SizedBox(height: 24),
        CustomButton(
          buttonText: AppLocalizations.of(context).topUp,
          onPressed: () async {
            if (_formKey2.currentState?.validate() ?? true) {
              context.loaderOverlay.show();
              try {
                double amount =
                    SharedCode.formatFromRupiah(_topUpController.text)
                        .toDouble();
                await BankRepository().addBalance(
                    SharedData.myAccountData.value!.accountNo, amount);
                SharedData.myAccountData.value = SharedData.myAccountData.value
                    ?.copyWith(
                        balance:
                            SharedData.myAccountData.value!.balance + amount);
                _topUpController.clear();
                _panelHeight.value = 70.h;
                _panelContent.value = _buildSuccessPanel(
                    isTopUp: true,
                    AppLocalizations.of(context).topUpSuccess,
                    AppLocalizations.of(context).topUpSuccessDescription);
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

  Widget _buildRequestBalancePanel() {
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
            Text(AppLocalizations.of(context).requestBalance,
                style: Theme.of(context)
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
              _buildSectionHeading(
                title: AppLocalizations.of(context).requestBalanceInstruction,
                description: AppLocalizations.of(context)
                    .requestBalanceInstructionDescription,
              ),
              const SizedBox(height: 16),
              _buildSteps([
                AppLocalizations.of(context).requestBalanceStep1,
                AppLocalizations.of(context).requestBalanceStep2,
                AppLocalizations.of(context).requestBalanceStep3,
                AppLocalizations.of(context).requestBalanceStep4
              ]),
              const SizedBox(height: 24),
              CustomTextField(
                controller: _usernameController,
                validator: SharedCode.emptyValidators,
                isRequired: true,
                label: AppLocalizations.of(context).username,
                hint: AppLocalizations.of(context).enterUsername,
                icon: Iconsax.frame5,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _amountController,
                validator: SharedCode.emptyValidators,
                isRequired: true,
                onChanged: (value) {
                  SharedCode.rupiahTextField(value, _amountController);
                },
                label: AppLocalizations.of(context).amount,
                hint: AppLocalizations.of(context).enterAmount,
                icon: Iconsax.empty_wallet5,
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _messageController,
                isRequired: false,
                label: AppLocalizations.of(context).message,
                hint: AppLocalizations.of(context).enterMessage,
                icon: Iconsax.document_text5,
                showOptional: true,
              ),
            ],
          ),
        )),
        const SizedBox(height: 24),
        CustomButton(
          buttonText: AppLocalizations.of(context).sendRequest,
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? true) {
              context.loaderOverlay.show();
              try {
                double amount =
                    SharedCode.formatFromRupiah(_amountController.text)
                        .toDouble();
                String username =
                    _usernameController.text.trimLeft().trimRight();
                UserModel userModel = await UserRepository().getUserByUsername(username);
                TransactionModel request = TransactionModel(
                    uid: userModel.uid!,
                    amount: amount,
                    createTime: DateTime.now().millisecondsSinceEpoch,
                    senderAccountNo: '',
                    traxType: DbConstants.transferOut,
                    receiverAccountNo: SharedData.myAccountData.value!.accountNo,
                    senderName: userModel.displayName,
                    relatedId: userModel.relatedId,
                    receiverName: SharedPreferencesService.getUserData()!.displayName);
                await TransactionRepository().addRequestedTransaction(request);
                _amountController.clear();
                _usernameController.clear();
                _messageController.clear();
                _panelHeight.value = 70.h;
                _panelContent.value = _buildSuccessPanel(
                    AppLocalizations.of(context).requestBalanceSuccess,
                    AppLocalizations.of(context)
                        .requestBalanceSuccessDescription);
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

  Widget _buildSectionHeading(
      {required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: UiConstant.mediumSpacing),
        Text(
          description,
          style:
              Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
        )
      ],
    );
  }

  Widget _buildSteps(List<String> steps) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (c, i) {
        return Row(children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
                child: Text(
              (i + 1).toString(),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.white, fontSize: 12),
            )),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              steps[i],
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 12, color: ColorValues.greyBase),
            ),
          ),
        ]);
      },
      separatorBuilder: (_, __) {
        return Row(
          children: [
            SizedBox(
              width: 20,
              child: Center(
                child: Container(
                  width: 1,
                  height: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const Spacer()
          ],
        );
      },
    );
  }

  Widget _buildSuccessPanel(String title, String description,
      {bool isTopUp = false}) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: UiConstant.sidePadding),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/core/img_action_success.svg',
                    width: 25.h,
                    height: 25.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: UiConstant.sidePadding),
              Text(
                title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: ColorValues.greyBase, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ]),
          ),
        ),
        const SizedBox(height: 24),
        Column(children: [
          CustomButton(
            buttonText: AppLocalizations.of(context).waitAtHome,
            onPressed: () {
              _panelController.close();
              AutoRouter.of(context).pop();
            },
          ),
          const SizedBox(height: 8),
          CustomButton(
            buttonText: isTopUp
                ? AppLocalizations.of(context).topUpBalanceAgain
                : AppLocalizations.of(context).requestBalanceAgain,
            colorAsOutlineButton: ColorValues.grey90,
            backgroundColor: ColorValues.slidingPanelBackground,
            onPressed: () {
              _panelController.close();
            },
          ),
        ]),
      ],
    );
  }
}
