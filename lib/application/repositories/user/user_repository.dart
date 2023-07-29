import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';

import '../../../data/models/user/user_model.dart';
import '../../common/db_constants.dart';
import 'base_user_repository.dart';

class UserRepository implements BaseUserRepository {
  @override
  Future<void> addOrUpdateUser(int uid, UserModel userModel) async {
    await DbConstants.db
        .collection(DbConstants.users)
        .doc(uid.toString())
        .set(userModel.toJson());
  }

  @override
  Future<UserModel> getUserById(int uid) async {
    DocumentSnapshot snapshot = await DbConstants.db.collection(DbConstants.users).doc(uid.toString()).get();
    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    }
    throw 'User tidak ditemukan';
  }

  @override
  Future<List<UserModel>> getMyChildren({int? limit}) async {
    var data = DbConstants.db.collection(DbConstants.users)
    .where('relatedId', isEqualTo: SharedPreferencesService.getAuthData()!.uid);
    if (limit != null) {
      data = data.limit(limit);
    }
    QuerySnapshot snapshot = await data.get();
    List<UserModel> list = [];
    print('snapshot ${snapshot.docs.length} ${SharedPreferencesService.getAuthData()!.uid}');
    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
        list.add(user);
      }
    }
    return list;
  }
}
