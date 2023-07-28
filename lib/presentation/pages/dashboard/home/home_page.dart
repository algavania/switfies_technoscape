import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/data/models/article/article_model.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/routes/router.gr.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_article.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_child_account.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_saving_balance.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ArticleModel _dummyArticle = ArticleModel(title: '5 Langkah Simpel Buatmu Sukses Dalam Menabung', thumbnailUrl: 'https://mediacloud.theweek.co.uk/image/private/s--X-WVjvBW--/f_auto,t_content-image-full-desktop@1/v1669803330/theweek/2022/November/143276835%20-%20savings%20accounts.jpg', content: '', readingInMinutes: 5, createdAt: DateTime.now());
  final List<TransactionModel> _dummyTransactions = [const TransactionModel(uid: 0, amount: 200000, createTime: 1686725002, senderAccountNo: '1234567890', traxType: 'Transfer Out', receiverAccountNo: '', senderName: 'Fulan bin Fulan', receiverName: 'Naluf bin Naluf', isNeedingApproval: true)];

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
              child: Column(
                children: [
                  const CustomSavingBalance(balance: 2200000),
                  const SizedBox(height: UiConstant.defaultSpacing),
                  _buildMenus(),
                  const SizedBox(height: UiConstant.defaultSpacing),
                  _buildApprovalRequests(),
                  const SizedBox(height: UiConstant.defaultSpacing),
                  _buildChildrenAccounts(),
                  const SizedBox(height: UiConstant.defaultSpacing),
                  _buildArticles(),
                ],
              ),
            ),
          ),
        ],
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
                title: AppLocalizations.of(context).saveNow,
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

  Widget _buildSectionHeading({required String title, required String description, required Function() onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          )),
          GestureDetector(
            onTap: onTap,
            child: Text(
              AppLocalizations.of(context).seeAll,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12, color: Theme.of(context).primaryColor),
            ),
          )
        ]),
        const SizedBox(height: UiConstant.mediumSpacing),
        Text(
          description,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
        )
      ],
    );
  }

  Widget _buildApprovalRequests() {
    return CustomShadow(
      isShadowAbove: true,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading(
                title: AppLocalizations.of(context).approvalRequestTitle,
                description: AppLocalizations.of(context).approvalRequestDescription,
                onTap: () {}
            ),
            const SizedBox(height: 16),
            _dummyTransactions.isEmpty
            ? SizedBox(
              width: 100.w,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(children: [
                  Text(
                    AppLocalizations.of(context).requestsEmptyTitle,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: UiConstant.mediumSpacing),
                  Text(
                    AppLocalizations.of(context).requestsEmptyDescription,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 12),
                  )
                ]),
              ),
            )
            : ListView.separated(
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

  Widget _buildChildrenAccounts() {
    return CustomShadow(
      isShadowAbove: true,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading(
              title: AppLocalizations.of(context).childrenAccountsTitle,
              description: AppLocalizations.of(context).childrenAccountsDescription,
              onTap: () {}
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

  Widget _buildArticles() {
    return CustomShadow(
      isShadowAbove: true,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
        color: ColorValues.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeading(
                title: AppLocalizations.of(context).duitKiddoArticleTitle,
                description: AppLocalizations.of(context).duitKiddoArticleDescription,
                onTap: () {}
            ),
            const SizedBox(height: 16),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return CustomArticle(article: _dummyArticle);
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
