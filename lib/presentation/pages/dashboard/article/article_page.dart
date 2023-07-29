import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../../application/common/shared_code.dart';
import '../../../../application/repositories/repositories.dart';
import '../../../../data/models/article/article_model.dart';
import '../../../../l10n/l10n.dart';
import '../../../core/color_values.dart';
import '../../../core/ui_constant.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_article.dart';
import '../../../widgets/custom_shadow.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<ArticleModel> _articleList = [];
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
      _articleList = await ArticleRepository().getArticleList(10);
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
              child: _isLoading ? Container(color: Colors.white) : Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: _buildArticles(),
                ),
              ),
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
