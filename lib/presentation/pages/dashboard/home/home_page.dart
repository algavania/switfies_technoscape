import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/application/repositories/repositories.dart';
import 'package:swifties_technoscape/data/models/article/article_model.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_article.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_child_account.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_transaction.dart';

import '../../../../application/common/db_constants.dart';
import '../../../../application/service/shared_preferences_service.dart';
import '../../../../data/models/account/account_model.dart';
import '../../../../data/models/saving/saving_model.dart';
import '../../../../data/models/user/user_model.dart';
import '../../../routes/router.gr.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<bool> _isBalanceVisible = ValueNotifier(false);
  List<UserModel> _childList = [];
  List<ArticleModel> _articleList = [];
  List<TransactionModel> _transactionList = [];
  bool _isLoading = true;
  bool _isParent = true;

  @override
  void initState() {
    _isParent = SharedPreferencesService.getUserData()!.role == DbConstants.parentRole;
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
      List<AccountModel> accounts = await BankRepository().getAllAccount();
      List<SavingModel> savings = await SavingRepository().getSavingList(null);
      if (accounts.isNotEmpty) {
        AccountModel account = accounts.first;
        num balance = account.balance;
        for (var data in savings) {
          balance -= data.currentSaving;
        }
        account = account.copyWith(balance: balance.toDouble());
        SharedData.myAccountData.value = account;
      }
      if (_isParent) {
        _childList = await UserRepository().getMyChildren(limit: 2);
        _transactionList = await TransactionRepository().getTransactions(limit: 2, isRequestedTransaction: true);
      }
      _articleList = await ArticleRepository().getArticleList(2);
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
                        child: Column(
                          children: [
                            _buildBalance(),
                            const SizedBox(height: UiConstant.defaultSpacing),
                            _buildMenus(),
                            const SizedBox(height: UiConstant.defaultSpacing),
                            if (_isParent) _buildApprovalRequests(),
                            if (_isParent) const SizedBox(height: UiConstant.defaultSpacing),
                            if (_isParent) _buildChildrenAccounts(),
                            if (_isParent)  const SizedBox(height: UiConstant.defaultSpacing),
                            _buildArticles(),
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

  Widget _buildBalance() {
    return ValueListenableBuilder(
        valueListenable: _isBalanceVisible,
        builder: (context, _, __) {
          return Container(
            padding: const EdgeInsets.symmetric(
                vertical: UiConstant.defaultPadding,
                horizontal: UiConstant.sidePadding),
            color: ColorValues.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).mainBalance,
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
                                      ' ${SharedCode.formatThousands(SharedData.myAccountData.value!.balance)}',
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
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
                  _buildBalanceToggle(),
                ]),
              ],
            ),
          );
        });
  }

  Widget _buildBalanceToggle() {
    return InkWell(
      onTap: () {
        _isBalanceVisible.value = !_isBalanceVisible.value;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorValues.text50, width: 1)),
        child: Row(
          children: [
            Icon(
              _isBalanceVisible.value ? Iconsax.eye_slash5 : Iconsax.eye4,
              color: ColorValues.text50,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              _isBalanceVisible.value
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

  Widget _buildMenus() {
    return CustomShadow(
      isShadowAbove: true,
      child: Container(
        padding: const EdgeInsets.all(UiConstant.defaultPadding),
        color: ColorValues.surface,
        child: Row(
          children: [
            Expanded(
              child: _buildMenuItem(
                title: AppLocalizations.of(context).createSavingTargetAlt,
                iconData: Iconsax.status_up5,
                iconColor: ColorValues.primary50,
                backgroundColor: ColorValues.primary10,
                onTap: () => AutoRouter.of(context).navigate(const SavingsRoute()),
              ),
            ),
            Expanded(
              child: _buildMenuItem(
                title: AppLocalizations.of(context).saveNowAlt,
                iconData: Iconsax.direct_inbox5,
                iconColor: ColorValues.success30,
                backgroundColor: ColorValues.success10,
                onTap: () {},
              ),
            ),
            Expanded(
              child: _buildMenuItem(
                title: AppLocalizations.of(context).interestCalculator,
                iconData: Iconsax.calculator5,
                iconColor: ColorValues.danger30,
                backgroundColor: ColorValues.danger10,
                onTap: () {},
              ),
            ),
            Expanded(
              child: _buildMenuItem(
                title: AppLocalizations.of(context).financeArticle,
                iconData: Iconsax.document_text5,
                iconColor: ColorValues.warning30,
                backgroundColor: ColorValues.warning10,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({required String title, required IconData iconData, required Color iconColor, required Color backgroundColor, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(UiConstant.smallerBorder)
          ),
          child: Icon(
            iconData,
            color: iconColor,
            size: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
          textAlign: TextAlign.center,
        )
      ]),
    );
  }


  Widget _buildSectionHeading(
      {required String title,
      required String description,
      required Function() onTap, required bool isListEmpty}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
              child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          )),
          if (!isListEmpty) GestureDetector(
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

  Widget _buildApprovalRequests() {
    return CustomShadow(
      isShadowAbove: true,
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
                title: AppLocalizations.of(context).approvalRequestTitle,
                description:
                    AppLocalizations.of(context).approvalRequestDescription,
                onTap: () {}),
            const SizedBox(height: 16),
            _transactionList.isEmpty
                ? _buildEmptyList(
                    AppLocalizations.of(context).requestsEmptyTitle,
                    AppLocalizations.of(context).requestsEmptyDescription)
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

  Widget _buildChildrenAccounts() {
    return CustomShadow(
      isShadowAbove: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading(
                isListEmpty: _childList.isEmpty,
                title: AppLocalizations.of(context).childrenAccountsTitle,
                description:
                    AppLocalizations.of(context).childrenAccountsDescription,
                onTap: () {}),
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

  Widget _buildArticles() {
    return CustomShadow(
      isShadowAbove: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: UiConstant.defaultPadding,
            horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading(
                isListEmpty: _articleList.isEmpty,
                title: AppLocalizations.of(context).duitKiddoArticleTitle,
                description:
                    AppLocalizations.of(context).duitKiddoArticleDescription,
                onTap: () {}),
            const SizedBox(height: 16),
            _articleList.isEmpty
                ? _buildEmptyList(
                    AppLocalizations.of(context).articleEmptyTitle,
                    AppLocalizations.of(context).articleEmptyDescription)
                : ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _articleList.length,
                    itemBuilder: (context, index) {
                      return CustomArticle(article: _articleList[index]);
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
}
