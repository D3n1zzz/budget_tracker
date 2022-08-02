import '../models/filter_class.dart';
import '../models/transaction.dart';

class FilterTransactionList {
  
  Filter filterState;
  List<Transaction> transactionList;

  FilterTransactionList(this.filterState, this.transactionList);

  List<Transaction> filteredTransactionList() {
    
    String? filterDescription = filterState.description;
    List<String?> filterIncomeCategory =
        filterState.incomeCategory?.entries.map((element) {
              if (element.value == true) {
                return element.key;
              } else {
                return '';
              }
            }).toList() ??
            [];

    List<String?> filterExpenseCategory =
        filterState.expenseCategory?.entries.map((element) {
              if (element.value == true) {
                return element.key;
              } else {
                return '';
              }
            }).toList() ??
            [];

    List<Transaction> filteredTransactionList = [];
    List<Transaction> filteredDescriptionList = [];

    if (filterDescription != null && filterDescription != '') {

      filteredDescriptionList.addAll(transactionList
          .where((element) => element.description == filterDescription));

    }

    if (filteredDescriptionList.isEmpty && filterDescription == '') {

      filteredTransactionList.addAll(transactionList
          .where((element) => filterIncomeCategory.contains(element.category.categoryName)));

    } else {

      filteredTransactionList.addAll(filteredDescriptionList
          .where((element) => filterIncomeCategory.contains(element.category.categoryName)));

    }

    if (filteredDescriptionList.isEmpty && filterDescription == '') {

      filteredTransactionList.addAll(transactionList.where(
          (element) => filterExpenseCategory.contains(element.category.categoryName)));

    } else {

      filteredTransactionList.addAll(filteredDescriptionList.where(
          (element) => filterExpenseCategory.contains(element.category.categoryName)));
    }

    if (filterState.dateRange != null) {

      DateTime startDate = filterState.dateRange!.start;
      DateTime endDate = filterState.dateRange!.end;

      List <Transaction> filteredDayRangeTransactionList = 
        filteredTransactionList.where((element) {
          return element.date.isAfter(startDate.subtract(const Duration(days: 1))) && 
            element.date.isBefore(endDate.add(const Duration(days: 1)));
        }).toList();   

      filteredTransactionList = [...filteredDayRangeTransactionList];
    }

    return filteredTransactionList;
  }
}
