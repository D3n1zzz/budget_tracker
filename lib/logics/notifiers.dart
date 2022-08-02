import 'package:expense_tracking_app/constants/buttons.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/button.dart';
import '../models/filter_class.dart';

class SelectedButtonNotifier extends StateNotifier<List<Button>> {
  SelectedButtonNotifier()
      : super(MainTimeRangeButtons().mainTimeRangeButtonGeneration());

  void buttonSelect(String selectedButtonName) {
    int index =
        state.indexWhere((element) => element.buttonName == selectedButtonName);
    int indexOfActiveButton =
        state.indexWhere((element) => element.isSelected == true);

    if (index != indexOfActiveButton) {
      state[index].isSelected = true;
      state[indexOfActiveButton].isSelected = false;

      state = [...state];
    }
  }

  bool isSelected(String buttonName) {
    int index = state.indexWhere((element) => element.buttonName == buttonName);
    return state[index].isSelected;
  }
}

// Adding transaction to notifier. When this state changes, other widges that listens this notifier will update themselves.
class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier() : super(Hive.box<Transaction>('transaction').values.toList());

  // Adding new transaction.
  void addTransaction(Transaction transaction) {
    state = [...state, transaction];
  }

  void resetTransactionListNotifier () {    
    state = [...state];
  }
  
  void deleteTransaction (Transaction deletedTransaction) {
    List <Transaction> tempList = List.from(state);
    tempList.removeWhere((element) => element.id == deletedTransaction.id);
    state = [...tempList];
  }
}

// Search page filter state notifier.
class FilterNotifier extends StateNotifier<List<Filter>> {
  FilterNotifier() : super([Filter(null, null, null, null)]);

  void changeFilter(Filter newFilterState) {
    state = [newFilterState];
  }
}

class FilteredTransactionListNotifier extends StateNotifier<List<Transaction>> {
  FilteredTransactionListNotifier() : super([]);

  void updateFilteredTransactionList(List<Transaction> newFilteredTransactionList) {
    state = [...newFilteredTransactionList];
  }
  void resetFilteredTransactionList () {
    state = [...state];
  }
  void deleteTransaction (Transaction deletedTransaction) {
    List <Transaction> tempList = List.from(state);
    tempList.removeWhere((element) => element.id == deletedTransaction.id);
    state = [...tempList];
  }

}

// ************After data structure is changed************************//


// Selecting the category is another widget. This notifier is used for notify the add_transaction class.
class AddTransactionSelectedCategoryNotifier extends StateNotifier <TransactionCategory> {

  AddTransactionSelectedCategoryNotifier() : super(TransactionCategory('', '', Colors.red.value));

  // To change selected category
  void changeSelectedTransactionCategory (TransactionCategory newSelectedCategory) {
    state = newSelectedCategory;
  }

  // When selectedCategoryType in the add_transaction form builder is empty, selected category will update itself to empty category.
  void deleteSelectedTransactionCategory () {
    TransactionCategory emptyCategory = TransactionCategory('', '', Colors.red.value);
    state = emptyCategory;
  }  
}

// Editing category notifier.
class EditTransactionCategoryNotifier extends StateNotifier <TransactionCategory> {
  // Sending a dummy category instance to parent class.
  EditTransactionCategoryNotifier() : super (TransactionCategory('', '', Colors.red.value));

  void editTransactionCategory (TransactionCategory editingTransactionCategory) {
    state = editingTransactionCategory;
  }
  void editingDoneTransactionCategory () {
    state = TransactionCategory('', '', Colors.red.value);
  }
}

class TransactionCategoryListNotifier extends StateNotifier <List<TransactionCategory>> {
  // When the application started, this command sends saved categories to notifier.
  TransactionCategoryListNotifier() : super(Hive.box <TransactionCategory> ('transactionCategory').toMap().values.toList());

  // Adding new transaction category to state.
  void addNewTransactionCategory (TransactionCategory newTransactionCategory) {
    state = [...state, newTransactionCategory];
  }
  void updateTransactionCategoryList () {
    state = [...state];
  }
  void deleteTransactionCategory (TransactionCategory deletedTransactionCategory) {
    int index = state.indexWhere((element) => 
      element.categoryType == deletedTransactionCategory.categoryType && element.categoryName == deletedTransactionCategory.categoryName);
    List <TransactionCategory> tempList = List.from(state);
    tempList.removeAt(index);
    state = [...tempList];
  }

}

class SortingButtonExpenseIncomeStateNotifier extends StateNotifier <List <SortingButtonExpenseIncome>> {

  SortingButtonExpenseIncomeStateNotifier() : super (SortTransactionListButtons().getSortingExpenseIncomeButtons());

  void updateSortingExpenseIncomeButtonStates() {

    state = [...state];

  }

}

class SortingOptionButtonStateNotifier extends StateNotifier <List <SortingOptionButton>> {

  SortingOptionButtonStateNotifier() : super (SortTransactionListButtons().getSortingOptionButtons());

  void updateSortingOptionButtonStates() {

    state = [...state];

  }

}
