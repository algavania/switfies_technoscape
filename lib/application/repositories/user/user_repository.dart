import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/user/user_model.dart';
import '../../../presentation/core/shared_data.dart';
import '../../common/db_constants.dart';
import 'base_user_repository.dart';

class UserRepository implements BaseUserRepository {
  @override
  Future<void> addOrUpdateUser(int uid, UserModel userModel) async {
    await DbConstants.db
        .collection(DbConstants.users)
        .doc(uid.toString())
        .set(userModel.toJson());
    SharedData.userData.value = userModel;
  }

  @override
  Future<UserModel> getUserById(int uid) async {
    DocumentSnapshot snapshot = await DbConstants.db.collection(DbConstants.users).doc(uid.toString()).get();
    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    }
    throw 'User tidak ditemukan';
  }
}
