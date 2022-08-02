import 'package:expense_tracking_app/constants/constant_categories.dart';
import 'package:expense_tracking_app/models/button.dart';
import 'package:expense_tracking_app/models/filter_class.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logics/notifiers.dart';

class Providers {

  // Home page selected button provider. Buttons are 'günlük', 'Haftalık',...
  // Listening widgets will update themselves according to selection
  static final selectedButtonProvider = StateNotifierProvider <SelectedButtonNotifier, List<Button>> ((ref) {
    return SelectedButtonNotifier();
  });

  // All transaction list provider.
  static final transactionListProvider = StateNotifierProvider <TransactionNotifier, List <Transaction>> ((ref) {
    return TransactionNotifier();
  });

  // Bottom navBar selected button provider.
  static final bottomNavBarIndexProvider = StateProvider<int>((ref) => 0);

  // Search page map provider which holds selected or unselected categories. Filter will be done according to this map.
  static final searchPageCategoryMapProvider = StateProvider((ref) => 
    {for (TransactionCategory category in ConstantCategories.constantTransactionCategoryList) category.categoryName : true });

  // Filter state provider. Filtered transaction list will be updated according to filter state.
  static final searchPageFilterProvider = StateNotifierProvider <FilterNotifier, List <Filter>> ((ref) {
    return FilterNotifier();
  }
  );

  // filtered transaction list will be updated according to filter state. 
  static final filteredTransactionListProvider = StateNotifierProvider <FilteredTransactionListNotifier, List<Transaction>>((ref) {
    return FilteredTransactionListNotifier();
 
  }
  );
  
  // Holds which transaction is in editing.
  static final editingTransactionProvider = StateProvider <Transaction> ((ref) => Transaction(0, 0, '', DateTime.now(), TransactionCategory('', '', Colors.red.value)));

  // Updates itself when editing is successful and other widgets will update themselves when editing is done.
  static final editingSuccessfullProvider = StateProvider <int> ((ref) => 0);
  
  static final statisticsPageSelectedButtonProvider = StateProvider((ref) => 'Haftalık');

  static final statisticsPageSelectedDateProvider = StateProvider((ref) => [(DateTime.now().day / 7).floor(), DateTime.now().month, DateTime.now().year]);

  static final statisticsPageSelectedPieChartButton = StateProvider ((ref) => 'Gelir');

  static final addPageTransactionTypeProvider = StateProvider((ref) => '');

  // *************************************************************************

  static final addTrasactionSelectedCategoryProvider = StateNotifierProvider <AddTransactionSelectedCategoryNotifier, TransactionCategory> ((ref) => 
    AddTransactionSelectedCategoryNotifier());

  // Holds value for new transaction category color defult value is Colors.red.
  static final addTransactionCategoryColorValueProvider = StateProvider((ref) => Colors.red.value);

  // Holds the color value of editing transaction default value is Colors.red.
  static final editTransactionCategoryColorValueProvider = StateProvider((ref) => Colors.red.value);

  // Holds all transaction list that created by user.
  static final transactionCategoryListProvider = StateNotifierProvider <TransactionCategoryListNotifier, List<TransactionCategory>> ((ref) => TransactionCategoryListNotifier());

  // Holds editing transaction instance.
  static final editTransactionCategoryProvider = StateNotifierProvider <EditTransactionCategoryNotifier, TransactionCategory> ((ref) => EditTransactionCategoryNotifier());


  // ************************
  //Main page sorting button state providers.
  static final sortingButtonExpenseIncomeProvider = StateNotifierProvider <SortingButtonExpenseIncomeStateNotifier, List<SortingButtonExpenseIncome>> ((ref){
    return SortingButtonExpenseIncomeStateNotifier();
  });

  static final sortingOptionButtonStateNotifier = StateNotifierProvider <SortingOptionButtonStateNotifier, List <SortingOptionButton>> ((ref) {
    return SortingOptionButtonStateNotifier();
  });
  // **************************
}