
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/saving/saving_model.dart';

abstract class BaseSavingRepository {
  Future<String> addSaving(SavingModel savingModel);
  Future<void> updateSaving(String savingId, SavingModel savingModel);
  Future<void> deleteSaving(String savingId);
  Future<List<SavingModel>> getSavingList(int? limit, {DocumentSnapshot document});
  Future<SavingModel> getSavingById(String savingId);
}
