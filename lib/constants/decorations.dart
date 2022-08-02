import 'package:expense_tracking_app/constants/constant_values.dart';
import 'package:flutter/material.dart';

class Decorations {
  Decorations._();

  static final mainPageButtonDecoration = BoxDecoration(
    color: ConstantValues.primaryColor.withOpacity(0.2),
  );

  static final mainPageShowSummaryDecoration = BoxDecoration(
    color: ConstantValues.primaryColor.withOpacity(0.2),
    borderRadius: BorderRadius.circular(10),
  );

  static final addPageDropDownMenuBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.black.withOpacity(0.2),
        width: 1,
      ));

  static final addPageDescriptionInputDecoration = InputDecoration(
    prefixIcon: const Icon(Icons.description),
    label: const Text('Açıklama'),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static final addPageQuantityInputDecoration = InputDecoration(
    prefixIcon: const Icon(Icons.production_quantity_limits),
    label: const Text('Miktar'),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static final addPageRadioButtonDecoration = BoxDecoration(
    border: Border.all(color: Colors.black.withOpacity(0.2), width: 2),
    borderRadius: BorderRadius.circular(10),
  );

  static final searchFilterButtonDecoration = BoxDecoration(
    color: ConstantValues.primaryColor.withOpacity(0.1),
    borderRadius: BorderRadius.circular(50),
  );

  static final searchFilteredTransactionDecoration = BoxDecoration(
    color: ConstantValues.primaryColor.withOpacity(0.1),
    borderRadius: BorderRadius.circular(10),
  );

  static final statisticsPageButtonDecoration = BoxDecoration(
    color: ConstantValues.primaryColor.withOpacity(0.2),
    borderRadius: BorderRadius.circular(30),
  );

  static final statisticsPageBarChartDecoration = BoxDecoration(
    color: ConstantValues.primaryColor.withAlpha(20),
    borderRadius: BorderRadius.circular(10),
  );

 
}
