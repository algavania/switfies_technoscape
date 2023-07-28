import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swifties_technoscape/application/common/shared_code.dart';
import 'package:swifties_technoscape/data/models/article/article_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_article.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_child_account.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_shadow.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<bool> _isBalanceVisible = ValueNotifier(false);
  final ArticleModel _dummyArticle = ArticleModel(title: '5 Langkah Simpel Buatmu Sukses Dalam Menabung', thumbnailUrl: 'https://mediacloud.theweek.co.uk/image/private/s--X-WVjvBW--/f_auto,t_content-image-full-desktop@1/v1669803330/theweek/2022/November/143276835%20-%20savings%20accounts.jpg', content: '', readingInMinutes: 5, createdAt: DateTime.now());

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
                  _buildBalance(),
                  const SizedBox(height: UiConstant.defaultSpacing),
                  _buildMenus(),
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

  Widget _buildBalance() {
    return ValueListenableBuilder(
      valueListenable: _isBalanceVisible,
      builder: (context, _, __) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: UiConstant.defaultPadding, horizontal: UiConstant.sidePadding),
          color: ColorValues.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context).yourSavings, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 14)),
              const SizedBox(height: 4),
              Row(children: [
                Expanded(
                  child: _isBalanceVisible.value ? RichText(
                    text: TextSpan(
                      text: 'Rp',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),
                      children: [
                        TextSpan(
                          text:' ${SharedCode.thousandSeparatorFormat(2200000)}',
                          style: Theme.of(context).textTheme.displayLarge,
                        )
                      ]
                    )
                  ) : SizedBox(
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
                            color: i % 2 == 0 ? ColorValues.primary30 : ColorValues.primary20,
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
      }
    );
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
          border: Border.all(color: ColorValues.text50, width: 1)
        ),
        child: Row(
          children: [
            Icon(
              _isBalanceVisible.value ? Iconsax.eye_slash5 : Iconsax.eye4,
              color: ColorValues.text50,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              _isBalanceVisible.value ? AppLocalizations.of(context).hide : AppLocalizations.of(context).show,
              style: Theme.of(context).textTheme.labelSmall,
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
                title: AppLocalizations.of(context).createSavingTarget,
                iconData: Iconsax.status_up5,
                iconColor: ColorValues.primary50,
                backgroundColor: ColorValues.primary10
              ),
            ),
            Expanded(
              child: _buildMenuItem(
                title: AppLocalizations.of(context).saveNow,
                iconData: Iconsax.direct_inbox5,
                iconColor: ColorValues.success30,
                backgroundColor: ColorValues.success10
              ),
            ),
            Expanded(
              child: _buildMenuItem(
                title: AppLocalizations.of(context).interestCalculator,
                iconData: Iconsax.calculator5,
                iconColor: ColorValues.danger30,
                backgroundColor: ColorValues.danger10
              ),
            ),
            Expanded(
              child: _buildMenuItem(
                title: AppLocalizations.of(context).financeArticle,
                iconData: Iconsax.document_text5,
                iconColor: ColorValues.warning30,
                backgroundColor: ColorValues.warning10
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({required String title, required IconData iconData, required Color iconColor, required Color backgroundColor}) {
    return Column(children: [
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
    ]);
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
