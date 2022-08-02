import '../models/transaction.dart';

class TotalFilteredTransactionValue {

  List <Transaction> filteredTransactionList;
  double totalFilteredIncomeValue = 0;
  double totalFilteredExpenseValue = 0;

  TotalFilteredTransactionValue(this.filteredTransactionList);

  double getTotalFilteredIncomeValue () {


    List<Transaction> filteredIncomeTransactionList = filteredTransactionList.where(((element) => element.category.categoryType == 'IncomeTransaction')).toList();

    for(var element in filteredIncomeTransactionList) {

      totalFilteredIncomeValue = totalFilteredIncomeValue + element.value;

    }
    
    return totalFilteredIncomeValue;

  }
  double getTotalFilteredExpenseValue () {


    List<Transaction> filteredExpenseTransactionList = filteredTransactionList.where(((element) => element.category.categoryType == 'ExpenseTransaction')).toList();

    for(var element in filteredExpenseTransactionList) {

      totalFilteredExpenseValue = totalFilteredExpenseValue + element.value;

    }
    
    return totalFilteredExpenseValue;

  }

}