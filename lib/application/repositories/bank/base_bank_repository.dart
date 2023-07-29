import '../../../data/models/account/account_model.dart';

abstract class BaseBankRepository {
  Future<AccountModel> createBankAccount(String token);
  Future<AccountModel> getAccountInfo(String token, String accountNo);
  Future<List<AccountModel>> getAllAccount();
  Future<void> addBalance(String accountNo, double amount);
}
