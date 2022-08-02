import 'package:expense_tracking_app/constants/constant_categories.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../providers/providers.dart';

class EditTransaction {

  GlobalKey <FormBuilderState> editingFormKey;
  Transaction editingTransaction;
  WidgetRef ref;

  EditTransaction(this.editingFormKey,this.editingTransaction, this.ref);

  void editTransaction () {

    DateTime newDate = editingFormKey.currentState!.fields['editingDate']!.value;
    String newTransactionCategoryType = editingFormKey.currentState!.fields['editingTransactionType']!.value;
    String newDescription = editingFormKey.currentState!.fields['editingDescription']!.value;
    double newValue = double.parse(editingFormKey.currentState!.fields['editingValue']!.value);
    String newCategoryName = editingFormKey.currentState!.fields['editingCategory']!.value;

    List <TransactionCategory> allTransactionCategoryList = [...ConstantCategories.constantTransactionCategoryList, 
      ...ref.read(Providers.transactionCategoryListProvider)];

    // Instead of creating a new transaction category, finding it from all transaction category list and assign to editing transaction.
    TransactionCategory newTransactionCategory = allTransactionCategoryList.singleWhere((element) => 
      element.categoryType == newTransactionCategoryType && element.categoryName == newCategoryName);

    editingTransaction.date = newDate;
    editingTransaction.description = newDescription;
    editingTransaction.value = newValue;
    editingTransaction.category = newTransactionCategory;

    // Updating filtered transaction list notifier. 
    ref.read(Providers.filteredTransactionListProvider.notifier).resetFilteredTransactionList();

    // Writing edited transaction to hive.
    Box <Transaction> box = Hive.box <Transaction> ('transaction');
    box.put(editingTransaction.id, editingTransaction);

  }

}