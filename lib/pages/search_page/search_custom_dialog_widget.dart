import 'package:collection/collection.dart';
import 'package:expense_tracking_app/constants/constant_categories.dart';
import 'package:expense_tracking_app/constants/constant_values.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/filter_class.dart';

class SearchCustomDialogWidget extends ConsumerStatefulWidget {
  const SearchCustomDialogWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchCustomDialogWidget> createState() =>
      _SearchCustomDialogWidgetState();
}

class _SearchCustomDialogWidgetState
    extends ConsumerState<SearchCustomDialogWidget> {

  Filter filterState = Filter(null, null, null, null);
  Map <String,bool> tempIncomeMap = {};
  Map <String,bool> tempExpenseMap = {};
  late List <TransactionCategory> allIncomeCategoryList;
  late List <TransactionCategory> allExpenseCategoryList;
  late List <TransactionCategory> allTransactionCategories;


  @override
  void initState() {

    filterState = ref.read(Providers.searchPageFilterProvider).last;

    allTransactionCategories = [...ConstantCategories.constantTransactionCategoryList, 
      ...ref.read(Providers.transactionCategoryListProvider)];

    allIncomeCategoryList = allTransactionCategories.where((element) => element.categoryType == 'IncomeTransaction').toList();
    allExpenseCategoryList = allTransactionCategories.where((element) => element.categoryType == 'ExpenseTransaction').toList();

    var tempIncomeMapInit = {for (TransactionCategory element in allIncomeCategoryList) element.categoryName : true};
    var tempExpenseMapInit = {for (TransactionCategory element in allExpenseCategoryList) element.categoryName : true};

    filterState.incomeCategory = Map.of(ref.read(Providers.searchPageFilterProvider).last.incomeCategory ?? tempIncomeMapInit);
    filterState.expenseCategory = Map.of(ref.read(Providers.searchPageFilterProvider).last.expenseCategory ?? tempExpenseMapInit);

    tempIncomeMap = Map.of(filterState.incomeCategory!);
    tempExpenseMap = Map.of(filterState.expenseCategory!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    allTransactionCategories = [...ConstantCategories.constantTransactionCategoryList, 
      ...ref.watch(Providers.transactionCategoryListProvider)];

    allIncomeCategoryList = allTransactionCategories.where((element) => element.categoryType == 'IncomeTransaction').toList();
    allExpenseCategoryList = allTransactionCategories.where((element) => element.categoryType == 'ExpenseTransaction').toList();   
   
    if (!(const ListEquality().equals(allIncomeCategoryList.map((e) => e.categoryName).toList(), tempIncomeMap.keys.toList()))){
      tempIncomeMap = Map.of({for (TransactionCategory element in allIncomeCategoryList) element.categoryName : true});
    }
    if (!(const ListEquality().equals(allExpenseCategoryList.map((e) => e.categoryName).toList(), tempExpenseMap.keys.toList()))) {
      tempExpenseMap = Map.of({for (TransactionCategory element in allExpenseCategoryList) element.categoryName : true});
    }

    return  Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Column(
        children: [
        Expanded(
          child: Row(
            children: [
              incomeCategorySelection(),
              VerticalDivider(
                color: ConstantValues.primaryColor.withOpacity(0.3),
                endIndent: 30,
                indent: 30,
                thickness: 2,
              ),
              expenseCategorySelection(),
            ],
          ),
        ),
        searchCategoryFilterButtons(),
      ]),
    );
  }

  Widget incomeCategorySelection() {
    
    List <String> incomeStringList = List.from(allIncomeCategoryList.map((e) => e.categoryName));

    return Expanded(
      child: Column(children: [
        const Text(
          'Gelir Kategorileri',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        OutlinedButton.icon(
          icon: const Icon(Icons.cancel_outlined),
          label: const Text('Temizle'),
          onPressed: () {
            setState(() {
              var clearedIncomeMap = {
                for (String element
                    in incomeStringList)
                  element: false
              };
              tempIncomeMap = Map.of(clearedIncomeMap);
            });
          },
        ),
        Expanded(
          child: ListView(
            children: incomeCategoryCheckBoxGenerate(incomeStringList),
          ),
        ),
      ]),
    );
  }

  List<Widget> incomeCategoryCheckBoxGenerate(List<String> incomeStringList) {

    return incomeStringList

        .map(
          (e) => CheckboxListTile(
              activeColor: ConstantValues.primaryColor,
              title: Text(e),
              value: tempIncomeMap[e],
              onChanged: (result) {
                setState(() {
                 tempIncomeMap[e] = result!;
                });
              }),
        )
        .toList();
  }

  Widget expenseCategorySelection() {

    List <String> expenseStringList = List.from(allExpenseCategoryList.map((e) => e.categoryName));

    return Expanded(
      child: Column(children: [
        const Text(
          'Gider Kategorileri',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        OutlinedButton.icon(
          icon: const Icon(Icons.cancel_outlined),
          label: const Text('Temizle'),
          onPressed: () {
            setState(() {
              var clearedExpenseMap = {
                for (String element in expenseStringList) element: false
              };
              tempExpenseMap = Map.of(clearedExpenseMap);
            });
          },
        ),
        Expanded(
          child: ListView(
            children: expenseCategoryCheckBoxGenerate(expenseStringList),
          ),
        ),
      ]),
    );
  }

  List<Widget> expenseCategoryCheckBoxGenerate(List<String> expenseStringList) {
    return expenseStringList
        .map((e) => CheckboxListTile(
            activeColor: ConstantValues.primaryColor,
            title: Text(e),
            value: tempExpenseMap[e],
            onChanged: (result) {
              setState(() {
                tempExpenseMap[e] = result!;
              });
            }))
        .toList();
  }

  Widget searchCategoryFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
            label: const Text('İptal'),
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.cancel_outlined)),
        TextButton.icon(
            label: const Text('Onayla'),
            onPressed: () {
              filterState.incomeCategory = Map.of(tempIncomeMap);
              filterState.expenseCategory = Map.of(tempExpenseMap);
              ref
                  .read(Providers.searchPageFilterProvider.notifier)
                  .changeFilter(filterState);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.check_box_outlined))
      ],
    );
  }
}
