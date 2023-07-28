import 'dart:convert';

import 'package:http/http.dart';
import 'package:swifties_technoscape/application/repositories/repositories.dart';

import '../../../data/models/response/response_model.dart';
import '../../../data/models/token/token_model.dart';
import '../../../data/models/user/user_model.dart';
import '../../service/network_service.dart';
import 'base_auth_repository.dart';

class AuthRepository implements BaseAuthRepository {
  @override
  Future<ResponseModel> createUser(UserModel userModel) async {
    Response res = await NetworkService.post(url: '/user/auth/create', body: userModel.toJson());
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
    print('model data ${model.data.runtimeType} ${model.data}');
    UserModel user = UserModel.fromJson(model.data);
    await UserRepository().addOrUpdateUser(user.uid, user);
    return model;
  }

  @override
  Future<TokenModel> generateToken(String username, password) async {
    Response res = await NetworkService.post(url: '/user/auth/token', body: {
      'username': username,
      'password': password
    });
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
    print('model data ${model.data.runtimeType} ${model.data}');
    return TokenModel.fromJson(model.data['accessToken']);
  }
}