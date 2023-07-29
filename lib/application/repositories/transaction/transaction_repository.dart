import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swifties_technoscape/data/models/user/user_model.dart';

import '../../../data/models/transaction/transaction_model.dart';
import '../../common/db_constants.dart';
import '../../service/shared_preferences_service.dart';
import 'base_transaction_repository.dart';

class TransactionRepository implements BaseTransactionRepository {
  @override
  Future<void> addRequestedTransaction(
      TransactionModel transactionModel) async {
    await DbConstants.db
        .collection(DbConstants.transactions)
        .add(transactionModel.toJson());
  }

  @override
  Future<List<TransactionModel>> getTransactions(
      {required int limit,
      required bool isRequestedTransaction,
      DocumentSnapshot<Object?>? document}) async {
    bool isParent =
        SharedPreferencesService.getUserData()!.role == DbConstants.parentRole;
    int uid = SharedPreferencesService.getUserData()!.uid!;
    Query<Map<String, dynamic>> query =
        DbConstants.db.collection(DbConstants.transactions);
    if (isParent) {
      query = query.where('relatedId', isEqualTo: uid);
    } else {
      query = query.where('uid', isEqualTo: uid);
    }
    if (isRequestedTransaction) {
      query = query.where('isApproved', isNull: isRequestedTransaction);
    } else {
      query = query.where('isApproved', isEqualTo: true);
    }
    query = query.orderBy('createTime');
    if (document != null) {
      query = query.startAfterDocument(document);
    }
    query = query.limit(limit);
    QuerySnapshot snapshot = await query.get();
    List<TransactionModel> list = [];
    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        TransactionModel model =
            TransactionModel.fromJson(doc.data() as Map<String, dynamic>);
        model = model.copyWith(id: doc.id, documentSnapshot: doc);
        list.add(model);
      }
    }
    return list;
  }

  @override
  Future<void> updateRequestedTransaction(
      String id, TransactionModel transactionModel) async {
    await DbConstants.db
        .collection(DbConstants.transactions)
        .doc(id)
        .update(transactionModel.toJson());
  }

  @override
  Future<void> addSavingTransactionHistory(
      String savingId, TransactionModel transactionModel) async {
    UserModel user = SharedPreferencesService.getUserData()!;
    await DbConstants.db
        .collection(DbConstants.users)
        .doc(user.uid!.toString())
        .collection(DbConstants.savings)
        .doc(savingId)
        .collection(DbConstants.transactions)
        .add(transactionModel.toJson());
  }

  @override
  Future<List<TransactionModel>> getSavingTransactionHistory(
      {required int limit,
      required String savingId,
      DocumentSnapshot<Object?>? document}) async {
    UserModel user = SharedPreferencesService.getUserData()!;
    var snapshot = await DbConstants.db
        .collection(DbConstants.users)
        .doc(user.uid!.toString())
        .collection(DbConstants.savings)
        .doc(savingId)
        .collection(DbConstants.transactions)
        .limit(limit)
        .get();
    List<TransactionModel> list = [];
    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        TransactionModel model = TransactionModel.fromJson(doc.data());
        model = model.copyWith(id: doc.id, documentSnapshot: doc);
        list.add(model);
      }
    }
    return list;
  }
}
