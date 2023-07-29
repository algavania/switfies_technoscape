import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
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
      try {
        _transactionList = await BankRepository().getAllTransactions(
            accountNo: SharedPreferencesService.getUserData()!.accountNo!,
            recordsPerPage: 3
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
                  'https://firebasestorage.googleapis.com/v0/b/swifties-technoscape.appspot.com/o/img_default_profile.png?alt=media&token=41b41973-531b-4f6e-95da-7b1e08f170a4',
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
                              if (SharedPreferencesService.getUserData()!.relatedId == null) _buildAddAccount(),
                              if (SharedPreferencesService.getUserData()!.relatedId == null) const SizedBox(height: UiConstant.defaultSpacing),
                              if (SharedPreferencesService.getUserData()!.relatedId == null) _buildChildrenAccounts(),
                              if (SharedPreferencesService.getUserData()!.relatedId == null) const SizedBox(height: UiConstant.defaultSpacing),
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
        onTap: () async {
          var data = await AutoRouter.of(context).push(const AddChildRoute());
          if (data is String) {
            SharedCode.showSnackbar(context: context, message: data);
            _getAllData();
          }
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
              isListEmpty: true,
              title: AppLocalizations.of(context).childrenAccountsTitle,
              description:
                  AppLocalizations.of(context).childrenAccountsDescription,
            ),
            const SizedBox(height: 16),
            _childList.isEmpty
                ? _buildEmptyList(
                    AppLocalizations.of(context).childrenAccountEmptyTitle,
                    AppLocalizations.of(context)
                        .childrenAccountEmptyDescription)
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
                          userId: SharedPreferencesService.getUserData()!.accountNo!,
                          refreshPage: _getAllData,
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
