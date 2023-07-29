import 'dart:convert';

import 'package:http/http.dart';
import 'package:swifties_technoscape/application/repositories/repositories.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';

import '../../../data/models/auth/auth_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/models/token/token_model.dart';
import '../../../data/models/user/user_model.dart';
import '../../service/network_service.dart';
import 'base_auth_repository.dart';

class AuthRepository implements BaseAuthRepository {
  @override
  Future<ResponseModel> createUser(AuthModel authModel, UserModel userModel, {bool isAuth = false}) async {
    Response res = await NetworkService.post(url: '/user/auth/create', body: authModel.toJson());
    print('res body ${res.body}');
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    print('model data ${model.data.runtimeType} ${model.data}');
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
    AuthModel resultAuth = AuthModel.fromJson(model.data);
    userModel = userModel.copyWith(uid: resultAuth.uid!);
    await UserRepository().addOrUpdateUser(userModel.uid!, userModel);
    if (isAuth) {
      await SharedPreferencesService.setAuthData(resultAuth);
      await SharedPreferencesService.setUserData(userModel);
    }
    return model;
  }

  @override
  Future<TokenModel> generateToken(String username, password) async {
    Response res = await NetworkService.post(url: '/user/auth/token', body: {
      'username': username,
      'loginPassword': password
    });
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
    print('model data ${model.data.runtimeType} ${model.data}');
    TokenModel result = TokenModel.fromJson(model.data);
    return result;
  }

  @override
  Future<AuthModel> getAuthInfo(String token) async {
    Response res = await NetworkService.post(url: '/user/info', token: token);
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
    AuthModel user = AuthModel.fromJson(model.data);
    return user;
  }
}