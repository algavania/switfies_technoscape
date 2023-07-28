import '../../../data/models/response/response_model.dart';
import '../../../data/models/token/token_model.dart';
import '../../../data/models/user/user_model.dart';

abstract class BaseAuthRepository {
  Future<ResponseModel> createUser(UserModel userModel);
  Future<TokenModel> generateToken(String username, password);
}
