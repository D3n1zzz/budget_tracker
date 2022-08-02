import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:flutter/material.dart';

// Constant transaction categories. User cannot modifiy these items.
class ConstantCategories {

  ConstantCategories._();

  static final List <String> constantExpenseList = [
    'Ev',
    'Ulaşım',
    'Market',
    'Giyim',
    'Sağlık',
    'Sigorta',
    'Kişisel',
    'Kredi',
    'Eğitim',
    'Yatırım Gideri',
    'Eğlence',
    'Diğer Gider'
  ];

  static final List <String> constantIncomeList = [
    'Maaş',
    'Yevmiye',
    'Komisyon',
    'Faiz',
    'Satış',
    'Yatırım Geliri',
    'Hediye',
    'Devlet Ödemesi',
    'Diğer Gelir'
  ];

  static final Map <String, Color> categoryColorList = {    
    'Ev': Colors.amberAccent,
    'Ulaşım':Colors.amber,
    'Market':Colors.blue,
    'Giyim':Colors.brown,
    'Sağlık':Colors.cyan,
    'Sigorta':Colors.deepOrange,
    'Kişisel':Colors.deepPurple,
    'Kredi':Colors.yellow,
    'Eğitim':Colors.green,
    'Yatırım':Colors.grey,
    'Eğlence':Colors.indigo,
    'Diğer Gider':Colors.lightBlue,
    'Maaş':Colors.orange,
    'Yevmiye':Colors.pink,
    'Komisyon':Colors.purple,
    'Faiz':Colors.red,
    'Satış':Colors.teal,
    'Hediye':Colors.yellowAccent,
    'Devlet Ödemesi':Colors.purpleAccent,
    'Diğer Gelir':Colors.redAccent,
  };

  static final List <TransactionCategory> constantTransactionCategoryList = categoryColorList.entries.map((e) {
    
    if (constantExpenseList.contains(e.key)){
      return TransactionCategory(e.key, 'ExpenseTransaction', e.value.value);
    }else {
      return TransactionCategory(e.key, 'IncomeTransaction', e.value.value);
    }
  }).toList();

}