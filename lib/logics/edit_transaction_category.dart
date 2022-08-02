import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/transaction.dart';

// Editing or deleting category
class EditTransactionCategory {

  GlobalKey <FormBuilderState> formKey;
  WidgetRef ref;

  EditTransactionCategory(this.formKey, this.ref);

  void editTransactionCategory() {

    TransactionCategory editingCategory = ref.read(Providers.editTransactionCategoryProvider);
    Box <TransactionCategory> box = Hive.box <TransactionCategory> ('transactionCategory');
    Box <Transaction> boxTransaction = Hive.box <Transaction>('transaction');
    int keyOfTransactionCategoryHive = box.toMap().entries.firstWhere((element) => 
      element.value.categoryType == editingCategory.categoryType && element.value.categoryName == editingCategory.categoryName).key;

    // Finding all transactions that have edited transaction category.
    List <Transaction> transactionListHaveEditedCategory = ref.read(Providers.transactionListProvider).where((element) => 
      element.category.categoryType == editingCategory.categoryType && element.category.categoryName == editingCategory.categoryName).toList();
  
    // Category new name is read from formKey.
    String categoryNewName = formKey.currentState!.fields['editingCategoryTextField']!.value;
    // Category new color value is read from provider.
    int categoryNewColorValue = ref.read(Providers.editTransactionCategoryColorValueProvider);

    // Updating category 
    editingCategory.categoryName = categoryNewName;
    editingCategory.categoryColorValue = categoryNewColorValue;

    for (Transaction transaction in transactionListHaveEditedCategory) {
      // Updating transaction categories.
      transaction.category = editingCategory;
      // Updating transaction Hive box.
      boxTransaction.put(transaction.id, transaction);
    }
    // Updating category list notifier.
    ref.read(Providers.transactionCategoryListProvider.notifier).updateTransactionCategoryList();
    // Updating transactionCategory Hive box.
    box.put(keyOfTransactionCategoryHive, editingCategory);
    // Updating transaction list notifier.
    ref.read(Providers.transactionListProvider.notifier).resetTransactionListNotifier();
    ref.read(Providers.filteredTransactionListProvider.notifier).resetFilteredTransactionList();
    // ref.read(Providers.transactionListProvider.notifier).editedDeletedCategoryTransactionModify(transactionListHaveEditedCategory);
    // Clearing editing transaction notifier.
    ref.read(Providers.editTransactionCategoryProvider.notifier).editingDoneTransactionCategory();
    

  }

}