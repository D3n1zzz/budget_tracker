import 'package:expense_tracking_app/constants/buttons.dart';
import 'package:expense_tracking_app/models/button.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SortTransactionList {

  WidgetRef ref;
  List <Transaction> transactionList;

  SortTransactionList(this.transactionList, this.ref);

  List <Transaction> sortedTransactionList () {

    List <SortingButtonExpenseIncome> expenseIncomeSortingButtonList = ref.read(Providers.sortingButtonExpenseIncomeProvider);
    List <SortingOptionButton> sortingOptionButtonList = ref.read(Providers.sortingOptionButtonStateNotifier);
    List <Transaction> sortedTransactionList = List.from(transactionList);
    List <Transaction> incomeTransactionList;
    List <Transaction> expenseTransactionList;

    // If one of the first expense or first income buttons are selected, then enters if statement.
    // Sorting will be done primarily on these buttons.

    if (expenseIncomeSortingButtonList.any((element) => element.isSelected == true)) {
      SortingButtonExpenseIncome pressedExpenseIncomeButton = expenseIncomeSortingButtonList.firstWhere((element) => element.isSelected == true);
      // First expense transactions
      if (pressedExpenseIncomeButton.buttonName == SortTransactionListButtons().sortTransactionListExpenseIncome.last) {
        incomeTransactionList = sortedTransactionList.where((element) => element.category.categoryType == 'IncomeTransaction').toList();
        expenseTransactionList = sortedTransactionList.where((element) => element.category.categoryType == 'ExpenseTransaction').toList();
      // Sorting only income or expense transactions then returns unified list.
      return [...sortTransactionsAccordingToDateAndValue(expenseTransactionList, sortingOptionButtonList), ...sortTransactionsAccordingToDateAndValue(incomeTransactionList, sortingOptionButtonList)];
      // First income transactions
      }else {
        incomeTransactionList = sortedTransactionList.where((element) => element.category.categoryType == 'IncomeTransaction').toList();
        expenseTransactionList = sortedTransactionList.where((element) => element.category.categoryType == 'ExpenseTransaction').toList();
      return [...sortTransactionsAccordingToDateAndValue(incomeTransactionList, sortingOptionButtonList), ...sortTransactionsAccordingToDateAndValue(expenseTransactionList, sortingOptionButtonList)];
      }   
      
    // If none of these buttons are selected,then sorting will be done according only date or value. 
    }else {
      return sortTransactionsAccordingToDateAndValue(sortedTransactionList, sortingOptionButtonList);
    }
   }

  List <Transaction> sortTransactionsAccordingToDateAndValue (List<Transaction> sortedTransactionList, List<SortingOptionButton> sortingOptionButtonList) {

    // Sorting according to date.
    if (sortingOptionButtonList[0].buttonState == 'increasing') {
      sortedTransactionList.sort((a,b) => b.date.compareTo(a.date));
      }else if (sortingOptionButtonList[0].buttonState == 'decreasing') {
      sortedTransactionList.sort((a,b) => a.date.compareTo(b.date));
    }

    // Sorting according to transaction value.
    if (sortingOptionButtonList[1].buttonState == 'increasing') {
      sortedTransactionList.sort((a,b) => b.value.compareTo(a.value));
    } else if (sortingOptionButtonList[1].buttonState == 'decreasing' ){
      sortedTransactionList.sort((a,b) => a.value.compareTo(b.value));
    }
    return sortedTransactionList;
  }

}