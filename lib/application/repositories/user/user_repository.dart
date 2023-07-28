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
}
