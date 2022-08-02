import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction.dart';

class StatisticsPageFilterTransactions {

  WidgetRef ref;

  StatisticsPageFilterTransactions(this.ref);

  Map <int, List<Transaction>> filterTransactions () {

    // Gets all transactions
    List <Transaction> transactionList = ref.read(Providers.transactionListProvider);
    // Gets selected button.
    String statisticsPageSelectedButton = ref.read(Providers.statisticsPageSelectedButtonProvider);
    // Gets cupertino date selections 
    List <int> statisticsPageSelectedDateList = ref.read(Providers.statisticsPageSelectedDateProvider);
    // Yearly transaction map. int value in the map represents months and the keys are filtered transaction list.
    Map <int, List<Transaction>> yearlyTransactionMap = {};
    // Monthly transaction map. int value in the map represents weeks and the keys are filtered transaction list.
    Map <int, List <Transaction>> monthlyTransactionMap = {};
    // Weekly transaction map. int value in the map represents days.
    Map <int, List<Transaction>> weeklyTransactionMap = {};

    int selectedYear = statisticsPageSelectedDateList[2];
    int selectedMonth = statisticsPageSelectedDateList[1];
    int selectedWeek = statisticsPageSelectedDateList[0];

    if (statisticsPageSelectedButton == 'Yıllık') {

      for(int i = 1; i <= 12; i++) {
        yearlyTransactionMap[i] = List.empty();
        yearlyTransactionMap[i] = List.from(transactionList.where((element) => element.date.month == i && element.date.year == selectedYear));
      } 

      return yearlyTransactionMap;

    } else if (statisticsPageSelectedButton == 'Aylık') {

      for (int i = 1; i <= 4; i++) {
        monthlyTransactionMap[i] = List.empty();
        monthlyTransactionMap[i] = List.from(transactionList.where((element) => element.date.year == selectedYear 
          && element.date.month == selectedMonth 
          && (element.date.day / 7 ).ceil() == i));
      }
      return monthlyTransactionMap;

    } else {

      Map <int, int> daysOfMonths  = {

        1: 31,
        2: isItLeapYear(selectedYear) ? 29 : 28,
        3: 31,
        4: 30,
        5: 31,
        6: 30,
        7: 31,
        8: 31,
        9: 30,
        10: 31,
        11: 30,
        12: 31
      };

      for (int i = (selectedWeek * 7) -  6; i <= (selectedWeek != 4 ? selectedWeek * 7 : (selectedWeek * 7 + (daysOfMonths[selectedMonth]! - selectedWeek * 7))); i++) {
        weeklyTransactionMap[i] = List.empty();
        weeklyTransactionMap[i] = List.from(transactionList.where((element) => element.date.year == selectedYear 
          && element.date.month == selectedMonth 
          && element.date.day == i));
      }
      return weeklyTransactionMap;
    }

  }

  bool isItLeapYear (int year) {

    if (year % 4 == 0 && year % 100 == 0 && year % 400 == 0) {
      return true;
    } else {
      return false;
    }

  }


}