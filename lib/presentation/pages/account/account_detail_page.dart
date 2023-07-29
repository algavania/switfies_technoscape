import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/data/models/account/account_model.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';
import 'package:swifties_technoscape/data/models/user/user_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_transaction.dart';

import '../../../application/repositories/repositories.dart';
import '../../../application/service/shared_preferences_service.dart';
import '../../../data/models/token/token_model.dart';

class AccountDetailPage extends StatefulWidget {
  final UserModel childModel;

  const AccountDetailPage({Key? key, required this.childModel})
      : super(key: key);

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  final ValueNotifier<bool> _isBalanceVisible = ValueNotifier(false);
  List<TransactionModel> _transactionList = [];

  bool _isLoading = true;
  late AccountModel _account;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.loaderOverlay.show();
    });
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
      TokenModel token = await AuthRepository().generateToken(widget.childModel.username, widget.childModel.loginPassword);
      _account = await BankRepository().getAccountInfo(token.accessToken, widget.childModel.accountNo!);
      try {
        _transactionList = await BankRepository().getAllTransactions(
            accountNo: widget.childModel.accountNo!,
            recordsPerPage: 50,
            token: token.accessToken
        );
      } catch (_) {}
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      SharedCode.showSnackbar(
          context: context, message: e.toString(), isSuccess: false);
    }
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: Column(
            children: [
              CustomAppBar(
                hasBackButton: true,
                body: Text(AppLocalizations.of(context).accountDetail,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Expanded(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: UiConstant.mediumPadding),
                      child: Column(children: [
                        _buildAccountDetail(),
                        const SizedBox(height: UiConstant.defaultSpacing),
                        _isLoading ? Container() :  _buildActivities(),
                      ])))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountDetail() {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: UiConstant.defaultPadding,
          horizontal: UiConstant.sidePadding),
      color: ColorValues.surface,
      child: Column(
        children: [
          Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: UiConstant.defaultSpacing),
            Expanded(
              child: Text(
                widget.childModel.displayName,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(width: UiConstant.defaultSpacing),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(
                    text: widget.childModel.accountNo!));
                SharedCode.showSnackbar(
                    context: context,
                    message: AppLocalizations.of(context)
                        .accountClipboardSuccess);
              },
              child: Row(children: [
                Text(
                  widget.childModel.accountNo ?? '-',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 12, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Iconsax.copy5,
                  size: 16,
                  color: ColorValues.primary90,
                )
              ]),
            ),
          ]),
          const SizedBox(height: UiConstant.defaultSpacing),
          ValueListenableBuilder(
              valueListenable: _isBalanceVisible,
              builder: (context, _, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context).childAccountBalance,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 14)),
                    const SizedBox(height: 4),
                    Row(children: [
                      Expanded(
                        child: _isBalanceVisible.value
                            ? RichText(
                                text: TextSpan(
                                    text: 'Rp',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(fontSize: 20),
                                    children: [
                                    TextSpan(
                                      text:
                                          ' ${SharedCode.formatThousands(_account.balance)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    )
                                  ]))
                            : SizedBox(
                                height: 12,
                                child: ListView.separated(
                                  primary: false,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 8,
                                  itemBuilder: (_, i) {
                                    return Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: i % 2 == 0
                                            ? ColorValues.primary30
                                            : ColorValues.primary20,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (_, __) {
                                    return const SizedBox(width: 4);
                                  },
                                ),
                              ),
                      ),
                      _buildBalanceToggle(_isBalanceVisible),
                    ]),
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget _buildBalanceToggle(ValueNotifier<bool> valueNotifier) {
    return InkWell(
      onTap: () {
        valueNotifier.value = !valueNotifier.value;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorValues.text50, width: 1)),
        child: Row(
          children: [
            Icon(
              valueNotifier.value ? Iconsax.eye_slash5 : Iconsax.eye4,
              color: ColorValues.text50,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              valueNotifier.value
                  ? AppLocalizations.of(context).hide
                  : AppLocalizations.of(context).show,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(letterSpacing: 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivities() {
    return CustomShadow(
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading(
              isListEmpty: _transactionList.isEmpty,
              title: AppLocalizations.of(context).lastActivityTitle,
              description: AppLocalizations.of(context).lastActivityDescription,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _transactionList.isEmpty
                ? _buildEmptyList(
                    AppLocalizations.of(context).childActivityEmptyTitle,
                    AppLocalizations.of(context).childActivityEmptyDescription)
                : ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _transactionList.length,
                    itemBuilder: (context, index) {
                      return CustomTransaction(
                          transactionModel: _transactionList[index]);
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

  Widget _buildEmptyList(String title, String description) {
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(children: [
          Text(
            title,
            style:
                Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14),
          ),
          const SizedBox(height: UiConstant.mediumSpacing),
          Text(
            description,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 12),
          )
        ]),
      ),
    );
  }

  Widget _buildSectionHeading(
      {required String title,
      required String description,
      required Function() onTap,
      required bool isListEmpty}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
              child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          )),
        ]),
        const SizedBox(height: UiConstant.mediumSpacing),
        Text(
          description,
          style:
              Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
        )
      ],
    );
  }
}
