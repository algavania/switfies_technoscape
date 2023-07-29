import 'package:flutter/material.dart';
import 'package:swifties_technoscape/data/models/article/article_model.dart';
import 'package:swifties_technoscape/presentation/widgets/custom_app_bar.dart';

import '../../../../l10n/l10n.dart';
import '../../../core/color_values.dart';
import '../../../core/ui_constant.dart';

class DetailArticlePage extends StatefulWidget {
  const DetailArticlePage({Key? key, required this.articleModel}) : super(key: key);
  final ArticleModel articleModel;

  @override
  State<DetailArticlePage> createState() => _DetailArticlePageState();
}

class _DetailArticlePageState extends State<DetailArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            const SizedBox(height: UiConstant.defaultSpacing),
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: UiConstant.defaultSpacing),
                  _buildArticleBody(),
                  const SizedBox(height: UiConstant.defaultSpacing),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleBody() {
    return Padding(
      padding: const EdgeInsets.all(UiConstant.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.articleModel.title, style: Theme.of(context).textTheme.titleMedium,),
          const SizedBox(height: UiConstant.defaultSpacing,),
          SizedBox(
              height: 120,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(UiConstant.defaultBorder),
                  child: Image.network(widget.articleModel.thumbnailUrl, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,))),
          const SizedBox(height: UiConstant.defaultSpacing,),
          Text(widget.articleModel.content, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      color: Colors.white,
      hasBackButton: true,
      body: Text(AppLocalizations.of(context).article, style: Theme.of(context).textTheme.titleMedium,),
    );
  }
}
