import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:swifties_technoscape/data/models/article/article_model.dart';
import 'package:swifties_technoscape/l10n/l10n.dart';
import 'package:swifties_technoscape/presentation/core/color_values.dart';
import 'package:swifties_technoscape/presentation/core/shared_data.dart';
import 'package:swifties_technoscape/presentation/core/ui_constant.dart';

class CustomArticle extends StatefulWidget {
  final ArticleModel article;
  const CustomArticle({Key? key, required this.article}) : super(key: key);

  @override
  State<CustomArticle> createState() => _CustomArticleState();
}

class _CustomArticleState extends State<CustomArticle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(UiConstant.mediumPadding),
      decoration: BoxDecoration(
        color: ColorValues.surface,
        border: Border.all(color: ColorValues.grey10, width: 1),
        borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(UiConstant.smallerBorder),
            child: Image.network(
              widget.article.thumbnailUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.article.title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12, decoration: TextDecoration.underline),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: UiConstant.defaultSpacing),
                Row(children: [
                  _buildIconText('${widget.article.readingInMinutes} ${AppLocalizations.of(context).minutes}', Iconsax.clock5),
                  Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: ColorValues.greyBase,
                      borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                  _buildIconText(SharedData.regularDateFormat.format(widget.article.createdAt), Iconsax.calendar)
                ])
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIconText(String text, IconData iconData) {
    return Row(children: [
      Icon(
        iconData,
        size: 16,
        color: ColorValues.greyBase,
      ),
      const SizedBox(width: 4),
      Text(
        text,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 10),
      )
    ]);
  }
}
