import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/routes/router.gr.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_transaction.dart';

import '../../../../application/common/shared_code.dart';
import '../../../../application/repositories/repositories.dart';
import '../../../../data/models/user/user_model.dart';
import '../../../widgets/custom_child_account.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<TransactionModel> _transactionList = [];
  List<UserModel> _childList = [];
  bool _isLoading = true;

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
      _childList = await UserRepository().getMyChildren();
      _transactionList = await TransactionRepository()
          .getTransactions(limit: 2, isRequestedTransaction: false);
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
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          _getAllData();
        },
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
              child: Stack(
                children: [
                  ListView(physics: const AlwaysScrollableScrollPhysics()),
                  _isLoading
                      ? Container()
                      : SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
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
                ],
              ),
            ),
          ],
        ),
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
                        AppLocalizations.of(context).newChildAccountTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: ColorValues.primary80, fontSize: 14),
                      ),
                      const SizedBox(height: UiConstant.mediumSpacing),
                      Text(
                        AppLocalizations.of(context).newChildAccountDescription,
                        style: Theme.of(context)
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
        padding: const EdgeInsets.symmetric(
            vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading(
              onTap: () {},
              isListEmpty: _childList.isEmpty,
              title: AppLocalizations.of(context).childrenAccountsTitle,
              description:
                  AppLocalizations.of(context).childrenAccountsDescription,
            ),
            const SizedBox(height: 16),
            _childList.isEmpty
                ? _buildEmptyList(
                AppLocalizations.of(context).childrenAccountEmptyTitle,
                AppLocalizations.of(context).childrenAccountEmptyDescription)
                : ListView.separated(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _childList.length,
              itemBuilder: (context, index) {
                return CustomChildAccount(
                  user: _childList[index],
                );
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
          if (!isListEmpty)
            GestureDetector(
              onTap: onTap,
              child: Text(
                AppLocalizations.of(context).seeAll,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 12, color: Theme.of(context).primaryColor),
              ),
            )
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
                    AppLocalizations.of(context).activityEmptyTitle,
                    AppLocalizations.of(context).activityEmptyDescription)
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
}
