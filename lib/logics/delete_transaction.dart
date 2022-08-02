import 'package:expense_tracking_app/models/transaction.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DeleteTransaction {

  Transaction deletedTransaction;
  WidgetRef ref;

  DeleteTransaction (this.deletedTransaction, this.ref);

  void deleteTransaction() {
    // Delete transaction from all transaction list notifier.
    ref.read(Providers.transactionListProvider.notifier).deleteTransaction(deletedTransaction);
    // Delete transaction from filtered transaction list notifier.
    ref.read(Providers.filteredTransactionListProvider.notifier).deleteTransaction(deletedTransaction);
    
    Box <Transaction> box = Hive.box<Transaction>('transaction');
    // Delete transaction from Hive.
    box.delete(deletedTransaction.id);
  }

}