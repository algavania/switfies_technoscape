import '../../../data/models/user/user_model.dart';

abstract class BaseUserRepository {
  Future<void> addOrUpdateUser(int uid, UserModel userModel);
  Future<UserModel> getUserById(int uid);
  Future<List<UserModel>> getMyChildren({int? limit});
}
