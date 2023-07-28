import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/user/user_model.dart';
import '../../../presentation/core/shared_data.dart';
import '../../common/db_constants.dart';
import 'base_user_repository.dart';

class UserRepository implements BaseUserRepository {
  @override
  Future<void> addOrUpdateUser(String uid, UserModel userModel) async {
    await DbConstants.db
        .collection(DbConstants.users)
        .doc(uid)
        .set(userModel.toJson());
    SharedData.userData.value = userModel;
  }

  @override
  Future<bool> checkIfUsernameExist(String username) async {
    QuerySnapshot snapshot = await DbConstants.db
        .collection(DbConstants.users)
        .where('username', isEqualTo: username)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  @override
  Future<void> setCurrentUserInfo() async {
    DocumentSnapshot snapshot = await DbConstants.db
        .collection(DbConstants.users)
        .doc(DbConstants.auth.currentUser?.uid)
        .get();
    if (snapshot.exists) {
      SharedData.userData.value = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    }
  }

  @override
  Future<UserModel> getUserById(String uid) async {
    DocumentSnapshot snapshot =
        await DbConstants.db.collection(DbConstants.users).doc(uid).get();
    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    }
    return UserModel(
        name: 'Anonim',
        email: 'anonim@gmail.com',
        username: 'Anonim',
        photoUrl: DbConstants.defaultPhotoProfileUrl,
        city: 'Surabaya',
        role: 'user',
        birthdate: DateTime.now(),
        createdAt: DateTime.now(),
    );
  }
}
