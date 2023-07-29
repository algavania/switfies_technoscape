
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/article/article_model.dart';

abstract class BaseArticleRepository {
  Future<String> addArticle(ArticleModel articleModel);
  Future<void> updateArticle(String articleId, ArticleModel articleModel);
  Future<void> deleteArticle(String articleId);
  Future<List<ArticleModel>> getArticleList(int limit, {DocumentSnapshot document});
}
