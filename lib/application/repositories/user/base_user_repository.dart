import '../../../data/models/user/user_model.dart';

abstract class BaseUserRepository {
  Future<bool> checkIfUsernameExist(String username);
  Future<void> setCurrentUserInfo();
  Future<void> addOrUpdateUser(String uid, UserModel userModel);
  Future<UserModel> getUserById(String uid);
}
