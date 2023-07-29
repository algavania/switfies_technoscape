import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';

import '../../../data/models/saving/saving_model.dart';
import '../../common/db_constants.dart';
import 'base_saving_repository.dart';

class SavingRepository implements BaseSavingRepository {
  @override
  Future<String> addSaving(SavingModel savingModel) async {
    DocumentReference reference = await DbConstants.db
        .collection(DbConstants.users)
        .doc(SharedPreferencesService.getUserData()!.uid!.toString())
        .collection(DbConstants.savings)
        .add(savingModel.toJson());
    return reference.id;
  }

  @override
  Future<void> updateSaving(String savingId, SavingModel savingModel) async {
    await DbConstants.db
        .collection(DbConstants.users)
        .doc(SharedPreferencesService.getUserData()!.uid!.toString())
        .collection(DbConstants.savings)
        .doc(savingId)
        .update(savingModel.toJson());
  }

  @override
  Future<void> deleteSaving(String savingId) async {
    await DbConstants.db
        .collection(DbConstants.users)
        .doc(SharedPreferencesService.getUserData()!.uid!.toString())
        .collection(DbConstants.savings)
        .doc(savingId)
        .delete();
  }

  @override
  Future<List<SavingModel>> getSavingList(int? limit, {DocumentSnapshot? document, String? uid}) async {
    List<SavingModel> list = [];
    Query<Map<String, dynamic>> query = DbConstants.db.collection(DbConstants.users)
        .doc(uid ?? SharedPreferencesService.getUserData()!.uid!.toString())
        .collection(DbConstants.savings);
    if (document != null) {
      query = query.startAfterDocument(document);
    }
    query = query.orderBy('createdAt', descending: true);
    if (limit != null) {
      query = query.limit(limit);
    }
    QuerySnapshot snapshot = await query.get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      SavingModel model = SavingModel.fromJson(doc.data() as Map<String, dynamic>);
      model = model.copyWith(documentSnapshot: doc, id: doc.id);
      list.add(model);
    }
    return list;
  }

  @override
  Future<SavingModel> getSavingById(String savingId) async {
    String id = SharedPreferencesService.getUserData()!.uid.toString();
    var snapshot = await DbConstants.db.collection(DbConstants.users).doc(id).collection(DbConstants.savings).doc(savingId).get();
    if (snapshot.exists) {
      SavingModel model = SavingModel.fromJson(snapshot.data() as Map<String, dynamic>);
      model = model.copyWith(id: snapshot.id, documentSnapshot: snapshot);
      return model;
    }
    throw 'Tabungan tidak tersedia';
  }
}