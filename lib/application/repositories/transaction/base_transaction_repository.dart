
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/transaction/transaction_model.dart';

abstract class BaseTransactionRepository {
  Future<void> addRequestedTransaction(TransactionModel transactionModel);
  Future<List<TransactionModel>> getTransactions({required int limit, required bool isRequestedTransaction, DocumentSnapshot? document});
  Future<void> updateRequestedTransaction(String id, TransactionModel transactionModel);
}
