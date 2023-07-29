import 'dart:convert';

import 'package:http/http.dart';
import 'package:swifties_technoscape/application/repositories/repositories.dart';
import 'package:swifties_technoscape/data/models/transaction/transaction_model.dart';

import '../../../data/models/account/account_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/models/user/user_model.dart';
import '../../common/db_constants.dart';
import '../../service/network_service.dart';
import '../../service/shared_preferences_service.dart';
import 'base_bank_repository.dart';

class BankRepository implements BaseBankRepository {
  @override
  Future<AccountModel> createBankAccount(String token) async {
    Response res = await NetworkService.post(
        url: '/bankAccount/create', token: token, body: {'balance': 0});
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
    AccountModel result = AccountModel.fromJson(model.data);
    return result;
  }

  @override
  Future<List<AccountModel>> getAllAccount() async {
    Response res = await NetworkService.post(
        url: '/bankAccount/info/all',
        token: SharedPreferencesService.getToken());
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
    List<AccountModel> result = [];
    print('model data ${model.data.runtimeType} ${model.data}');
    for (var data in model.data['accounts'] as List<dynamic>) {
      AccountModel accountModel =
          AccountModel.fromJson(data as Map<String, dynamic>);
      result.add(accountModel);
    }
    return result;
  }

  @override
  Future<AccountModel> getAccountInfo(String token, String accountNo) async {
    Response res = await NetworkService.post(
        url: '/bankAccount/info', token: token, body: {'accountNo': accountNo});
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
    AccountModel result = AccountModel.fromJson(model.data);
    return result;
  }

  @override
  Future<void> addBalance(String accountNo, double amount) async {
    Response res = await NetworkService.post(
        url: '/bankAccount/addBalance',
        token: SharedPreferencesService.getToken(),
        body: {'receiverAccountNo': accountNo, 'amount': amount});
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
  }

  @override
  Future<void> createTransaction(String senderAccountNo,
      String receiverAccountNo, double amount, String token) async {
    Response res = await NetworkService.post(
        url: '/bankAccount/transaction/create',
        token: token,
        body: {
          'senderAccountNo': senderAccountNo,
          'receiverAccountNo': receiverAccountNo,
          'amount': amount
        });
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
  }

  @override
  Future<List<TransactionModel>> getAllTransactions(
      {required String accountNo,
      int pageNumber = 1,
      int recordsPerPage = 50}) async {
    Response res = await NetworkService.post(
        url: '/bankAccount/transaction/info',
        body: {
          'accountNo': accountNo,
          'pageNumber': pageNumber,
          'recordsPerPage': recordsPerPage
        },
        token: SharedPreferencesService.getToken());
    ResponseModel model = ResponseModel.fromJson(jsonDecode(res.body));
    if (model.errMsg != null) {
      throw model.errMsg!.isNotEmpty ? model.errMsg! : 'Error';
    }
    List<TransactionModel> result = [];
    print('model data ${model.data.runtimeType} ${model.data}');
    for (var data in model.data['transactions'] as List<dynamic>) {
      TransactionModel model =
          TransactionModel.fromJson(data as Map<String, dynamic>);
      String displayName = 'Top Up';
      if (model.senderAccountNo != DbConstants.topUpId) {
        UserModel user = await UserRepository().getUserByAccountNo(model.senderAccountNo);
        displayName = user.displayName;
      }
      UserModel receiver = await UserRepository().getUserByAccountNo(model.receiverAccountNo);
      model = model.copyWith(
        receiverName: receiver.displayName,
        senderName: displayName
      );
      result.add(model);
    }
    return result;
  }
}
