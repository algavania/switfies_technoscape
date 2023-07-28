import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/routes/router.gr.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_child_account.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_transaction.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final TransactionModel _dummyTransaction1 = const TransactionModel(uid: 0, amount: 200000, createTime: 1686725002, senderAccountNo: '0000000000', traxType: 'Transfer In', receiverAccountNo: '', senderName: 'E-Wallet', receiverName: 'Fulan bin Fulan', isNeedingApproval: false);
  final TransactionModel _dummyTransaction2 = const TransactionModel(uid: 0, amount: 200000, createTime: 1686725002, senderAccountNo: '1234567890', traxType: 'Transfer Out', receiverAccountNo: '', senderName: 'Fulan bin Fulan', receiverName: 'Naluf bin Naluf', isNeedingApproval: false);
  List<TransactionModel> _dummyTransactions = [];

  @override
  void initState() {
    _dummyTransactions = [_dummyTransaction1, _dummyTransaction2];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(
            needSpacing: true,
            body: ClipRRect(
              borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
              child: Image.network(
                'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg',
                width: 40,
                height: 40,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  vertical: UiConstant.mediumPadding),
              child: Column(
                children: [
                  _buildAddAccount(),
                  const SizedBox(height: UiConstant.defaultSpacing),
                  _buildChildrenAccounts(),
                  const SizedBox(height: UiConstant.defaultSpacing),
                  _buildActivities(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAccount() {
    return CustomShadow(
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).navigate(const AddChildRoute());
        },
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
                            .newChildAccountTitle,
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
                            .newChildAccountDescription,
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

  Widget _buildChildrenAccounts() {
    return CustomShadow(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading(
              title: AppLocalizations
                  .of(context)
                  .childrenAccountsTitle,
              description: AppLocalizations
                  .of(context)
                  .childrenAccountsDescription,
            ),
            const SizedBox(height: 16),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return const CustomChildAccount(name: 'Fulan bin Fulan');
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

  Widget _buildSectionHeading(
      {required String title, required String description, Function()? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(child: Text(
            title,
            style: Theme
                .of(context)
                .textTheme
                .labelLarge,
          )),
          if (onTap != null) GestureDetector(
            onTap: onTap,
            child: Text(
              AppLocalizations
                  .of(context)
                  .seeAll,
              style: Theme
                  .of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 12, color: Theme
                  .of(context)
                  .primaryColor),
            ),
          )
        ]),
        const SizedBox(height: UiConstant.mediumSpacing),
        Text(
          description,
          style: Theme
              .of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontSize: 12),
        )
      ],
    );
  }

  Widget _buildActivities() {
    return CustomShadow(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading(
              title: AppLocalizations.of(context).lastActivityTitle,
              description: AppLocalizations.of(context).lastActivityDescription,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _dummyTransactions.length,
              itemBuilder: (context, index) {
                return CustomTransaction(transactionModel: _dummyTransactions[index]);
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