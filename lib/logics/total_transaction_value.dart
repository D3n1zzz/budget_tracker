import 'package:expense_tracking_app/constants/buttons.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import '../models/button.dart';

class TotalTransactionQuantity {

  List<Transaction> transactionList;
  Button selectedButton;

  List<Transaction> dailyTransactions = [];
  List<Transaction> weeklyTransactions = [];
  List<Transaction> monthlyTransactions = [];
  List<Transaction> yearlyTransactions = [];

  TotalTransactionQuantity(this.transactionList, this.selectedButton);


  bool getYearlyTransactions(Transaction element, DateTime currentDate) {
    return element.date.year == currentDate.year;
  }

  bool getMonthlyTransactions(Transaction element, DateTime currentDate) {
    return (element.date.month == currentDate.month &&
        element.date.year == currentDate.year);
  }

  bool getWeeklyTransactions(Transaction transaction, DateTime currentDate) {
    int currentDay = currentDate.day;
    int remainder = currentDay % 7;
    late bool result;

    if (remainder != 0) {
      List<int> daysIncluded =
          List.generate(remainder, (index) => currentDay - index);

      result = daysIncluded.contains(transaction.date.day) &&
          currentDate.month == transaction.date.month;

    } else if (remainder == 0) {
      List<int> daysIncluded =
          List.generate(7, (index) => currentDay - index);

      result = daysIncluded.contains(transaction.date.day) &&
          currentDate.month == transaction.date.month;
    }

    return result;
  }

  bool getDailyTransactions(Transaction element, DateTime currentDate) {
    int currentMonth = currentDate.month;
    int currentDay = currentDate.day;

    return (element.date.day == currentDay &&
        element.date.month == currentMonth);
  }

  Map<String, double> getTotalMap(List<Transaction> transactions) {

    double totalIncome = 0;
    double totalExpense = 0;

    for (Transaction element in transactions) {
      double currentValue = element.value;
      if (element.category.categoryType == 'IncomeTransaction') {
        totalIncome += currentValue;
      } else if (element.category.categoryType == 'ExpenseTransaction') {
        totalExpense += currentValue;
      }
    }

    Map<String, double> totalMap = {
      'IncomeTransaction': totalIncome,
      'ExpenseTransaction': totalExpense,
    };
    return totalMap;
  }

  List <Transaction> getTransactionListAcccordingToSelectedButton() {

    List <String> buttonNames = MainPageButtons.mainTimeRangeButtonNames;
    var currentDate = DateTime.now();

    dailyTransactions = transactionList
          .where((element) => getDailyTransactions(element, currentDate))
          .toList();

      weeklyTransactions = transactionList
          .where((element) => getWeeklyTransactions(element, currentDate))
          .toList();

      monthlyTransactions = transactionList
          .where((element) => getMonthlyTransactions(element, currentDate))
          .toList();

      yearlyTransactions = transactionList
          .where((element) => getYearlyTransactions(element, currentDate))
          .toList();

    if (selectedButton.buttonName == buttonNames[0]) {
      return dailyTransactions;
    }else if (selectedButton.buttonName == buttonNames[1]) {
      return weeklyTransactions;
    }else if (selectedButton.buttonName == buttonNames[2]) {
      return monthlyTransactions;
    }else if (selectedButton.buttonName == buttonNames[3]) {
      return yearlyTransactions;
    } else {
      return transactionList;
    }

  }

  Map<String, double> getTotalTransactionQuantity() {    

    List <Transaction> transactionListAccordingToSelectedButton = getTransactionListAcccordingToSelectedButton();

    return getTotalMap(transactionListAccordingToSelectedButton);

  }
  
}
