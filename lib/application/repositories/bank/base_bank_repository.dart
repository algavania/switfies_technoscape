import '../../../data/models/account/account_model.dart';

abstract class BaseBankRepository {
  Future<AccountModel> createBankAccount(String token);
  Future<List<AccountModel>> getAllAccount();
}
