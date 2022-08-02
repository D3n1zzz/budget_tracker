import 'dart:math' as math;
import 'package:expense_tracking_app/constants/constant_values.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class StatisticsBarChartData {

  Map <int, List<Transaction>> transactionMap;
  WidgetRef ref;

  StatisticsBarChartData(this.transactionMap, this.ref);

  List <BarChartGroupData> getBarChartGroupData () {

    return transactionMap.entries.map((e) => 
     BarChartGroupData(
       x: e.key,
       barRods: getRodData(e.value),
       )).toList();

  }

  List <BarChartRodData> getRodData (List<Transaction> transactionList) {

    double totalExpense = 0;
    double totalIncome = 0;
    late BarChartRodData incomeRodData;
    late BarChartRodData expenseRodData;
    List<BarChartRodData> rodDataList = [];

    for (Transaction transaction in transactionList) {

      if (transaction.category.categoryType == 'IncomeTransaction') {

        totalIncome += transaction.value;

      }else {

        totalExpense += transaction.value;

      }

    }
    incomeRodData = BarChartRodData(            
      color: Colors.green,
      toY: totalIncome);
    expenseRodData = BarChartRodData(
      color: Colors.red,
      toY: totalExpense);

    rodDataList.add(incomeRodData);
    rodDataList.add(expenseRodData);

    return rodDataList;

  }

  FlTitlesData getTitlesData() {

    FlTitlesData titlesData  = FlTitlesData(      
      show: true,
      rightTitles: AxisTitles(        
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(          
          reservedSize: 80,
          showTitles: true,
          getTitlesWidget: (double value, TitleMeta meta) => getBottomTitles(value, meta),
        ),
      ),
      leftTitles: AxisTitles(       
        sideTitles: SideTitles(          
          reservedSize: 50,        
          interval: getLeftTitleInterval() != 0 ? getLeftTitleInterval() : 100,
          showTitles: true,          
          getTitlesWidget: (double value, TitleMeta meta) => getLeftTitles(value, meta),
        )
      )
    );
    return titlesData;
  }
  
  Widget getBottomTitles(double value, TitleMeta meta) {

    List<int> selectedDateButtonList = ref.read(Providers.statisticsPageSelectedDateProvider);
    String selectedButton = ref.read(Providers.statisticsPageSelectedButtonProvider);

    int selectedMonth = selectedDateButtonList[1];
    String monthName = ConstantValues.monthNamesMap[selectedMonth]!;

    TextStyle style = const TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.bold      
    );

    switch(selectedButton) {

      case 'Haftalık':
        return RotatedBox(
        quarterTurns: -1,
        child: Text(value.toStringAsFixed(0) + ' $monthName', style: style,));
      case 'Aylık':
        return RotatedBox(
        quarterTurns: -1,
        child: Text('$monthName ${value.toStringAsFixed(0)} .Hafta', style: style,));
      case 'Yıllık':
        return RotatedBox(
        quarterTurns: -1,
        child: Text('${ConstantValues.monthNamesMap[value]}', style: style,));
    }
  return const Text('Hata');

  }

  Widget getLeftTitles(double value, TitleMeta meta) {

    TextStyle style = const TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.bold
    );

    if(value < 1000) {

       return Text((value).toStringAsFixed(1), style: style,);

    }

    return Text((value/1000).toStringAsFixed(2) + 'k', style: style,);
  }

  // double getGroupSpace() {

  //   String selectedButton = ref.read(Providers.statisticsPageSelectedButtonProvider);
  //   List<int> selectedTimeRangeList = ref.read(Providers.statisticsPageSelectedDateProvider);
    
  //   switch (selectedButton) {

  //     case 'Haftalık':
  //       if(selectedTimeRangeList[0] == 4) {
  //         return 30;
  //       }
  //       return 45;
  //     case 'Aylık':
  //       return 100;
  //     case 'Yıllık':
  //       return 18;
  //   }
  // return 15;

  // }
  
  double getLeftTitleInterval() {

    List <double> totalIncomeList = [];
    List <double> totalExpenseList = [];
    double maxIncome = 0;
    double maxExpense = 0;

    for (List <Transaction> currentTransactionList in transactionMap.values) {

      double totalIncome = 0;
      double totalExpense = 0;

        for (Transaction transaction in currentTransactionList) {

          if (transaction.runtimeType.toString() == 'IncomeTransaction') {
            totalIncome += transaction.value;
            
          }else {
            totalExpense += transaction.value;
          }
          totalIncomeList.add(totalIncome);
          totalExpenseList.add(totalExpense);
        }
              
    }

    if(totalIncomeList.isNotEmpty && totalExpenseList.isNotEmpty) {
      maxIncome = totalIncomeList.reduce(math.max);
      maxExpense = totalExpenseList.reduce(math.max);
    }


    return (maxIncome >= maxExpense ? maxIncome : maxExpense) / 10;

  }
  
}