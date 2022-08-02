import 'package:expense_tracking_app/constants/constant_categories.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticsPagePieChartData {

  Map <int, List<Transaction>> filteredTransactionMap;
  WidgetRef ref;
  late List <TransactionCategory> allTransactionCategoryList;

  StatisticsPagePieChartData(this.filteredTransactionMap, this.ref);

  // Holds total values of all transactions according to selected button and date.
  Map <String, double> pieChartTransactionMapAccordingToCategories = {};

  List <PieChartSectionData> getPieChartSections (String selectedButton) {

    // Title value location => for odds value titles will be farher from center of the circle.
    int counter = 0;

    allTransactionCategoryList = [...ConstantCategories.constantTransactionCategoryList, 
      ...ref.read(Providers.transactionCategoryListProvider)];

    List <Transaction> incomeTransactionList = getIncomeTransactions();
    List <Transaction> expenseTransactionList = getExpenseTransactions();
    List <PieChartSectionData>? pieChartSectionDataList;
    // Total value map according to categories.

    //***********this statement finds all transactions categories that represents incomes.
    // first initiliaze all values of the categories to 0
    if (selectedButton == 'Gelir') {

      for (TransactionCategory category in allTransactionCategoryList) {

        if (category.categoryType == 'IncomeTransaction') {

          pieChartTransactionMapAccordingToCategories[category.categoryName] = 0;

        }
      }
     //************

      //*********Holds total value of all income transactions that represents income transaction  
      for (Transaction transaction in incomeTransactionList) {

        double value = pieChartTransactionMapAccordingToCategories[transaction.category.categoryName]!;

        pieChartTransactionMapAccordingToCategories[transaction.category.categoryName] = value + transaction.value; 

      }


    // Finding expense categories and initiliazes to 0 for all expense categories.
    } else {

      for (TransactionCategory category in allTransactionCategoryList) {

        if (category.categoryType == 'ExpenseTransaction') {

          pieChartTransactionMapAccordingToCategories[category.categoryName] = 0;

        }

      }

      for (Transaction transaction in expenseTransactionList) {

        double value = pieChartTransactionMapAccordingToCategories[transaction.category.categoryName]!;

        pieChartTransactionMapAccordingToCategories[transaction.category.categoryName] = value + transaction.value; 

      }

    }

    // *******Checks whether there are any filtered transaction. If not, then returns empty section data.
    if (pieChartTransactionMapAccordingToCategories.entries.every((element) => element.value == 0)) {
      pieChartSectionDataList = [
        PieChartSectionData( 
          radius: getPieChartRadius(),
          value: 100,
          title: 'Veri yok',
        )
      ];
    } else {

      pieChartSectionDataList = pieChartTransactionMapAccordingToCategories.entries.map((e) {

      Color pieSectionColor = Color(allTransactionCategoryList.singleWhere((element) => element.categoryName == e.key).categoryColorValue);
      
      if (e.value != 0) {
        counter++;

        return PieChartSectionData(          
          badgePositionPercentageOffset: counter.isEven ? 1.2 : 1,
          badgeWidget: Text(getPieChartPercentValue(pieChartTransactionMapAccordingToCategories, e.value).toStringAsFixed(2) + '% ' + e.key, style:  getPieChartTitleTextStyle(),),
          color: pieSectionColor,
          radius: getPieChartRadius(),
          value: e.value,
          title: '',
        );
      } else {
        return PieChartSectionData(
          radius: getPieChartRadius(),
          value: 0,
          title: '',
        );
      }
    }).toList();

    }


    return pieChartSectionDataList;    

  }


  // ********** finds all transactions that represents income. Then adds those transactions to a list.
  List<Transaction> getIncomeTransactions() {

    List <Transaction> transactions = [];

    for (List<Transaction> transactionList in filteredTransactionMap.values) {
      for(Transaction transaction in transactionList) {
        if (transaction.category.categoryType == 'IncomeTransaction') {
          transactions.add(transaction);
        }
      }
    }
    return transactions;
  }
  // **********

  // ********** finds all transactions that represents expense. Then adds those transactions to a list.  
  List<Transaction> getExpenseTransactions() {

    List <Transaction> transactions = [];

    for (List<Transaction> transactionList in filteredTransactionMap.values) {
      for(Transaction transaction in transactionList) {
        if (transaction.category.categoryType== 'ExpenseTransaction') {
          transactions.add(transaction);
        }
      }
    }
  return transactions;

  }
  // ***********
  
  double getPieChartPercentValue(Map<String, double> transactionMap, double categoryValue) {

    double totalValue = 0;

    for (double value in transactionMap.values) {

      if (value != 0) {

        totalValue += value;

      }

    }    

    return categoryValue * 100 / totalValue;

  }
  
  TextStyle getPieChartTitleTextStyle() {

    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    
  }
  TextStyle getPieChartLegendTextStyle() {

    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    
  }
  
  double getPieChartRadius() {

    return 120;

  }

  double getPieChartCenterRadius () {

    return getPieChartRadius()/10;

  }


  List <Widget> getPieChartColorLegends() {

    List <Widget> pieChartLegendList = [];

    if (pieChartTransactionMapAccordingToCategories.values.every((element) => element == 0)) {
      return [const Text('Veri yok')];

    } else {
      pieChartLegendList = pieChartTransactionMapAccordingToCategories.entries.map((e){

        if (e.value != 0) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Color(allTransactionCategoryList.firstWhere((element) => element.categoryName == e.key).categoryColorValue),
                ),
                const VerticalDivider(
                  thickness: 1,
                ),
                Text(e.key, style: getPieChartLegendTextStyle(),),
              ],
            ),
          );
       }else {
         return const Text(' ');
       }
      }).toList();
    }
    return pieChartLegendList;
  }
  
}
