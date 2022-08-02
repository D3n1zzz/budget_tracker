import 'package:expense_tracking_app/constants/constant_categories.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DeleteTransactionCategory {

  WidgetRef ref;

  DeleteTransactionCategory (this.ref);

  void deleteTransactionCategory () {
    // Reading category from provider.
    TransactionCategory deletedTransactionCategory = ref.read(Providers.editTransactionCategoryProvider);
    // Reading all transactions from provider.
    List <Transaction> allTransactionList = ref.read(Providers.transactionListProvider);
    // Getting transaction categories from Hive.
    Box <TransactionCategory> boxTransactionCategory = Hive.box <TransactionCategory> ('transactionCategory');
    // Getting key of deleted transaction category
    int keyOfDeletedTransactionCategory = boxTransactionCategory.toMap().entries.firstWhere((element) =>
      element.value.categoryType == deletedTransactionCategory.categoryType && element.value.categoryName == deletedTransactionCategory.categoryName).key;
    // Getting transactions from Hive.
    Box <Transaction> box = Hive.box <Transaction> ('transaction');
    // Getting transactions that have deleted category.
    List <Transaction> transactionListHaveDeletedCategory = allTransactionList.where((element) => 
      element.category.categoryType == deletedTransactionCategory.categoryType && element.category.categoryName == deletedTransactionCategory.categoryName).toList();
    for (Transaction transaction in transactionListHaveDeletedCategory) {
      // Updating transaction categories.
      transaction.category = ConstantCategories.constantTransactionCategoryList.last;
      // Writing to Hive.
      box.put(transaction.id, transaction);
    }
    // Updating transaction category list notifier.
    ref.read(Providers.transactionCategoryListProvider.notifier).deleteTransactionCategory(deletedTransactionCategory);
    // Reseting all transaction list notifier.
    ref.read(Providers.transactionListProvider.notifier).resetTransactionListNotifier();
    // Reseting filtered filtered transaction list notifier.
    ref.read(Providers.filteredTransactionListProvider.notifier).resetFilteredTransactionList();
    // Delete transaction category from Hive.
    boxTransactionCategory.delete(keyOfDeletedTransactionCategory);
    ref.read(Providers.editTransactionCategoryProvider.notifier).editingDoneTransactionCategory();
  } 


}