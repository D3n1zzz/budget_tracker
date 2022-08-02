import 'package:expense_tracking_app/logics/sort_transaction_list.dart';
import 'package:expense_tracking_app/logics/total_transaction_value.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../constants/decorations.dart';
import '../../models/button.dart';
import '../../providers/providers.dart';
import 'package:intl/date_symbol_data_local.dart';

class MainTransactionListWidget extends ConsumerWidget {
  const MainTransactionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
       
    List <Transaction> transactionList = ref.watch(Providers.transactionListProvider);
    List <Button> mainTimeRangeButtonList = ref.watch(Providers.selectedButtonProvider);
    int indexOfSelected = mainTimeRangeButtonList.indexWhere((element) => element.isSelected == true);
    Button selectedButton = mainTimeRangeButtonList[indexOfSelected];

    // Getting transaction list according selected time range button in the main page.
    List <Transaction> getTransactionListAcccordingToSelectedButton = 
      TotalTransactionQuantity(transactionList, selectedButton).getTransactionListAcccordingToSelectedButton();
    List <Transaction> sortTransactionList = List.from(SortTransactionList(getTransactionListAcccordingToSelectedButton, ref).sortedTransactionList());    
    ref.watch(Providers.sortingButtonExpenseIncomeProvider);
    ref.watch(Providers.sortingOptionButtonStateNotifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DecoratedBox(
        decoration: Decorations.mainPageShowSummaryDecoration,
        child: SizedBox(
          height: 430,
          child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: sortTransactionList.length,
              itemBuilder: ((context, index) {
                Transaction transaction = sortTransactionList[index];
                String transactionType = transaction.category.categoryType;
                initializeDateFormatting('tr_TR', null).then((value) => null);              
                String date = DateFormat.yMd('tr_Tr').format(transaction.date);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10) ),
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                      radius: 15,
                      backgroundColor: getAvatarColor(transactionType),
                      child: Text('${(index + 1)}'.toString()),
                    ),
                    title: Text(transaction.description.toString()),
                    subtitle: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(transaction.category.categoryName.toString()),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(date.toString()),
                        ],
                      ),
                    ),
                    trailing: Text(transaction.value.toStringAsFixed(2) + ' TL'),
                    
                        
                  ),
                );
              })),
        ),
      ),
    );
  }

  Color getAvatarColor(String transactionType) {

    return transactionType == 'IncomeTransaction'
        ? Colors.green
        : Colors.red;
  }
}
