import 'dart:convert';

import 'package:http/http.dart';

import '../../../data/models/account/account_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../service/network_service.dart';
import '../../service/shared_preferences_service.dart';
import 'base_bank_repository.dart';

class BankRepository implements BaseBankRepository {
  @override
  Future<AccountModel> createBankAccount(String token) async {
    Response res = await NetworkService.post(url: '/bankAccount/create', token: token, body: {
      'balance': 0
    });
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
    AccountModel result = AccountModel.fromJson(model.data);
    return result;
  }

  @override
  Future<List<AccountModel>> getAllAccount() async {
    Response res = await NetworkService.post(url: '/bankAccount/info/all', token: SharedPreferencesService.getToken());
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
    List<AccountModel> result = [];
    print('model data ${model.data.runtimeType} ${model.data}');
    for (var data in model.data['accounts'] as List<dynamic>) {
      AccountModel accountModel = AccountModel.fromJson(data as Map<String, dynamic>);
      result.add(accountModel);
    }
    return result;
  }

  @override
  Future<AccountModel> getAccountInfo(String token, String accountNo) async {
    Response res = await NetworkService.post(url: '/bankAccount/info', token: token, body: {
      'accountNo': accountNo
    });
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
    AccountModel result = AccountModel.fromJson(model.data);
    return result;
  }
}