import 'package:expense_tracking_app/logics/total_transaction_value_filtered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/decorations.dart';
import '../../constants/text_styles.dart';
import '../../models/transaction.dart';
import '../../providers/providers.dart';

class SearchPageShowTotalSummaryWidget extends ConsumerWidget {
  const SearchPageShowTotalSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    List<Transaction> filteredTransactionList =
        ref.watch(Providers.filteredTransactionListProvider);
    double resultIncome = TotalFilteredTransactionValue(filteredTransactionList)
        .getTotalFilteredIncomeValue();
    double resultExpense =
        TotalFilteredTransactionValue(filteredTransactionList)
            .getTotalFilteredExpenseValue();
    double netResult = resultIncome - resultExpense;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          showSummary(resultIncome, 'totalIncome'),
          showSummary(netResult, 'netValue'),
          showSummary(resultExpense, 'totalExpense'),
        ]),
    );
  }

  Widget showSummary(double result, String type) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: SizedBox(
        height: 100,
        child: DecoratedBox(
        decoration: Decorations.searchFilterButtonDecoration,
        child: Center(          
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children:[
                  Text(getShowSummaryText(type)),
                  const Divider(
                    height: 10,
                    color: Colors.black,
                  ),
                  Text(result.toStringAsFixed(2) + ' TL', style: TextStyles().getSearchPageShowSummaryTextStyle(type, result))
                ] ))),
        ),
    ),
    );
  }
  
  String getShowSummaryText(String type) {

    switch (type) {
      case 'totalIncome':
        return 'Toplam Gelir';
      case 'netValue':
        return 'Net Değer';
      case 'totalExpense':
        return 'Toplam Gider';
    }
    return 'Hata';
  }
}
