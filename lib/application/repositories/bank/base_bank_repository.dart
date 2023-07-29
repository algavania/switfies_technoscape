import '../../../data/models/account/account_model.dart';
import '../../../data/models/transaction/transaction_model.dart';

abstract class BaseBankRepository {
  Future<AccountModel> createBankAccount(String token);
  Future<AccountModel> getAccountInfo(String token, String accountNo);
  Future<List<AccountModel>> getAllAccount();
  Future<void> addBalance(String accountNo, double amount);
  Future<void> createTransaction(String senderAccountNo, String receiverAccountNo, double amount, String token);
  Future<List<TransactionModel>> getAllTransactions({required String accountNo, int pageNumber = 1, int recordsPerPage = 50, String? token});
}
