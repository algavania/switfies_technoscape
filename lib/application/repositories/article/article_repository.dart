import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:swifties_technoscape/data/models/article/article_model.dart';

import '../../common/db_constants.dart';
import 'base_article_repository.dart';

class ArticleRepository implements BaseArticleRepository {
  @override
  Future<String> addArticle(ArticleModel articleModel) async {
    DocumentReference reference = await DbConstants.db
        .collection(DbConstants.articles)
        .add(articleModel.toJson());
    return reference.id;
  }

  @override
  Future<void> updateArticle(String articleId, ArticleModel articleModel) async {
    await DbConstants.db
        .collection(DbConstants.articles)
        .doc(articleId)
        .update(articleModel.toJson());
  }

  @override
  Future<void> deleteArticle(String articleId) async {
    await DbConstants.db.collection(DbConstants.articles).doc(articleId).delete();
    await DbConstants.storage.ref('${DbConstants.articles}/$articleId.png').delete();
  }

  @override
  Future<List<ArticleModel>> getArticleList(int limit, {DocumentSnapshot? document}) async {
    List<ArticleModel> list = [];
    Query<Map<String, dynamic>> query = DbConstants.db.collection(DbConstants.articles);
    if (document != null) {
      query = query.startAfterDocument(document);
    }
    QuerySnapshot snapshot = await query
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      ArticleModel model = ArticleModel.fromJson(doc.data() as Map<String, dynamic>);
      model = model.copyWith(documentSnapshot: doc, id: doc.id);
      list.add(model);
    }
    return list;
  }
}