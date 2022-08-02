import 'dart:math';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction.dart';

// This class is used for creating transaction, putting it into the hive box and updating riverpod provider.
// To create a new transaction instance.
class AddTransaction {

  GlobalKey<FormBuilderState> formKey;
  WidgetRef ref;
  AddTransaction(this.formKey, this.ref);
  late Box <Transaction> box;

  void addTransaction() {

    late Transaction transaction;

      box = Hive.box <Transaction> ('transaction');

      DateTime date = formKey.currentState!.fields['date']!.value;
      String description = formKey.currentState!.fields['description']!.value;
      double quantity = double.parse(formKey.currentState!.fields['quantity']!.value);

      // To read selected category from the corresponding widget.
      TransactionCategory category = ref.read(Providers.addTrasactionSelectedCategoryProvider);
      
      // To get last index of existing transactions. 
      //This ensures there are no transactions that have same id.
      // This also checks for empty hive box.
      int lastIndex = box.toMap().isNotEmpty ? box.toMap().values.map((Transaction element) => element.id).reduce(max) : 0;

      // Creating new transaction instance.
      transaction = Transaction(lastIndex + 1, quantity, description, date, category);

      // Writing to Hive.
      box.put(transaction.id, transaction);

      // Updating transactionListNotifier.
      ref.read(Providers.transactionListProvider.notifier).addTransaction(transaction);

  }
}
