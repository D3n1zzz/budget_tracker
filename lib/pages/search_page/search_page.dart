import 'package:expense_tracking_app/constants/constant_categories.dart';
import 'package:expense_tracking_app/logics/filtered_transaction_list.dart';
import 'package:expense_tracking_app/logics/get_filtered_transaction_list_suggestions.dart';
import 'package:expense_tracking_app/models/filter_class.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:expense_tracking_app/pages/search_page/search_custom_dialog_widget.dart';
import 'package:expense_tracking_app/pages/search_page/search_page_show_total_summary.dart';
import 'package:expense_tracking_app/pages/search_page/show_filtered_transactions_list.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import '../../constants/decorations.dart';
import '../../models/transaction.dart';

class SearchPageWidget extends ConsumerStatefulWidget {
  const SearchPageWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends ConsumerState<SearchPageWidget> {

  Filter filterState = Filter(null, null, null, null);
  late List<Transaction> transactionList;
  List<TransactionCategory> allIncomeCategoryList = [];
  List <TransactionCategory> allExpenseCategoryList = [];
  late Map <String,bool> tempIncomeMapInit;
  late Map <String, bool> tempExpenseMapInit;
  late List <TransactionCategory> allTransactionCategory;

  DateTimeRange? dateRange;
  TextEditingController textConroller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    textConroller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {

    // Getting all transactions from constant categories and transaction category notifier.
    allTransactionCategory = [...ConstantCategories.constantTransactionCategoryList, ...ref.read(Providers.transactionCategoryListProvider)];
    allIncomeCategoryList = allTransactionCategory.where((element) => element.categoryType == 'IncomeTransaction').toList();
    allExpenseCategoryList = allTransactionCategory.where((element) => element.categoryType == 'ExpenseTransaction').toList();

    tempIncomeMapInit = {
      for (TransactionCategory element in allIncomeCategoryList)
        element.categoryName : true
    };

    tempExpenseMapInit = {
      for (TransactionCategory element
          in allExpenseCategoryList)
        element.categoryName : true
    };

    filterState.incomeCategory = Map.of(tempIncomeMapInit);
    filterState.expenseCategory = Map.of(tempExpenseMapInit);

    super.initState();
  }

  @override
  Widget build(BuildContext context) { 
    
    transactionList = ref.watch(Providers.transactionListProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TypeAheadField<Transaction> (              
              noItemsFoundBuilder: (context){
                return const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Bulunamadı'));
              },
              hideSuggestionsOnKeyboardHide: false,
              textFieldConfiguration: TextFieldConfiguration(
                focusNode: focusNode,
                controller: textConroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  hintText: 'Açıklama Ara'
                ),
              ),
              suggestionsCallback:(String query){
                return GetTransactionSuggestions.getTransactionSuggestion(transactionList, query);
              }, 
              itemBuilder: (context, suggestion){              
                return ListTile(
                  title: Text(suggestion.description.toString()),
                  trailing: Text(suggestion.value.toString() + ' TL'),
                  subtitle: Text(suggestion.category.categoryName),
                );
              },
              onSuggestionSelected: (Transaction? suggestion) {
                if (suggestion == null) {
                  return;
                } else {
                  textConroller.text = suggestion.description;
                }
              },
            ),
                     
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DecoratedBox(
                decoration: Decorations.searchFilterButtonDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: showDateRange(dateRange),
                      onPressed: () {
                        pickDateRange(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Kategori'),
                      onPressed: () {
                        showMultiSelectDialogCustom(context);
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            focusNode.unfocus();
                            var tempIncomeMapInit = {
                              for (TransactionCategory element in allIncomeCategoryList)
                                element.categoryName : true
                            };
                            var tempExpenseMapInit = {
                              for (TransactionCategory element in allExpenseCategoryList)
                                element.categoryName : true
                            };
                            filterState.incomeCategory =
                                Map.of(tempIncomeMapInit);
                            filterState.expenseCategory =
                                Map.of(tempExpenseMapInit);
                            dateRange = null;
                            textConroller.text = '';
                            filterState.dateRange = dateRange;
                            filterState.description = textConroller.text;
                            ref
                                .read(Providers.searchPageFilterProvider.notifier)
                                .changeFilter(filterState);
                            List<Transaction> filteredTransactionList =
                                FilterTransactionList(
                                        filterState, transactionList)
                                    .filteredTransactionList();
                            ref
                                .read(Providers
                                    .filteredTransactionListProvider.notifier)
                                .updateFilteredTransactionList(
                                    filteredTransactionList);
                          });
                        },
                        icon: const Icon(Icons.cancel_outlined)),
                    IconButton(
                        onPressed: () {
                          focusNode.unfocus();
                          filterState.dateRange = dateRange;
                          filterState.description = textConroller.text;
                          ref
                              .read(Providers.searchPageFilterProvider.notifier)
                              .changeFilter(filterState);
                          List<Transaction> filteredTransacitionList =
                              FilterTransactionList(filterState, transactionList)
                                  .filteredTransactionList();
                          ref
                              .read(Providers
                                  .filteredTransactionListProvider.notifier)
                              .updateFilteredTransactionList(
                                  filteredTransacitionList);
                        },
                        icon: const Icon(Icons.arrow_forward_ios)),
                  ],
                ),
              ),
            ),
          ),
          const ShowFilteredTransactionListWidget(),
          const SearchPageShowTotalSummaryWidget(),
        ],
      ),
    );
  }

  Future pickDateRange(context) async {
    DateTimeRange? selectedDateRange = await showDateRangePicker(
        context: context, firstDate: DateTime(2020), lastDate: DateTime.now());

    if (selectedDateRange == null) return;
    setState(() {
      dateRange = selectedDateRange;
    });
  }

  Widget showDateRange(DateTimeRange? dateRange) {
    if (dateRange == null) {
      return const Text('Zaman Aralığı');
    } else {
      DateTime startDate = dateRange.start;
      DateTime endDate = dateRange.end;
      DateFormat newFormat = DateFormat('dd-MM-yyyy');
      String startDateString = newFormat.format(startDate);
      String endDateString = newFormat.format(endDate);
      return Text(
        startDateString + '\n' + endDateString,
        style: const TextStyle(fontSize: 15),
      );
    }
  }

  void showMultiSelectDialogCustom(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const SearchCustomDialogWidget();
        });
  }
}
