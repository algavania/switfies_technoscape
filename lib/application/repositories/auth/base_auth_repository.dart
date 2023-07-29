import '../../../data/models/auth/auth_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/models/token/token_model.dart';
import '../../../data/models/user/user_model.dart';

abstract class BaseAuthRepository {
  Future<ResponseModel> createUser(AuthModel authModel, UserModel userModel, {bool isAuth = false});
  Future<TokenModel> generateToken(String username, password);
  Future<AuthModel> getAuthInfo(String token);
}
