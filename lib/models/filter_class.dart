import 'package:flutter/material.dart';


class Filter {

  String? description;
  DateTimeRange? dateRange;
  Map <String, bool>? incomeCategory;
  Map <String, bool>? expenseCategory;

  Filter (this.description, this.dateRange, this.incomeCategory, this.expenseCategory);

  @override
  String toString() {
    
      return incomeCategory.toString();
  }

 }