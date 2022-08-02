import 'package:flutter/material.dart';

class TextStyles {

  TextStyles();

  TextStyle getSearchPageShowSummaryTextStyle(String type, double result) {

    late Color summaryColor;

    switch(type) {

      case 'totalIncome':
        summaryColor = Colors.green;
      break;
      case 'netValue':
        if(result < 0){
          summaryColor = Colors.red;
        }else if (result == 0) {
          summaryColor = Colors.grey;
        }else{
          summaryColor = Colors.green;
        }
      break;
      case 'totalExpense':
        summaryColor = Colors.red;
      break;
    }

    return TextStyle(      
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: summaryColor,      
    );
  }

  TextStyle getSortTransactionListButtonTextStyle() {

    return const TextStyle(
      fontSize: 13,      
    );


  }

}
