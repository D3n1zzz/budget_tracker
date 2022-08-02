import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddTransactionCategory {

  GlobalKey <FormBuilderState> formKey;
  WidgetRef ref;

  AddTransactionCategory(this.formKey, this.ref);

  void addNewCategory () {

    late TransactionCategory newTransactionCategory;
    Box box = Hive.box <TransactionCategory> ('transactionCategory');

    String newCategoryType = ref.read(Providers.addPageTransactionTypeProvider);
    String newCategoryName = formKey.currentState!.fields['addCategoryTextField']!.value;
    int newCategoryColorValue = ref.read(Providers.addTransactionCategoryColorValueProvider);

    if (newCategoryType == 'Income') {
      // Creating new category instance according to selected transaction type
      newTransactionCategory = TransactionCategory(newCategoryName, 'IncomeTransaction', newCategoryColorValue);
    }else {
      // Creating new category instance according to selected transaction type
      newTransactionCategory = TransactionCategory(newCategoryName, 'ExpenseTransaction', newCategoryColorValue);
    }
    // Adding new transaction category instance to notifier.
    ref.read(Providers.transactionCategoryListProvider.notifier).addNewTransactionCategory(newTransactionCategory); 
    // Clearing editTransaction notifier.
    ref.read(Providers.editTransactionCategoryProvider.notifier).editingDoneTransactionCategory();                    
    // Adding new transaction category instance to Hive.
    box.add(newTransactionCategory);
  }

}