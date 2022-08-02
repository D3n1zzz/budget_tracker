import 'package:expense_tracking_app/constants/decorations.dart';
import 'package:expense_tracking_app/logics/total_transaction_value.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/button.dart';
import '../../providers/providers.dart';

class MainShowSummaryWidget extends ConsumerWidget {
  const MainShowSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    List <Button> buttonList = ref.watch(Providers.selectedButtonProvider);
    List <Transaction> transactionList = ref.watch(Providers.transactionListProvider);
    int indexOfSelected = buttonList.indexWhere((element) => element.isSelected == true);
    Button selectedButton = buttonList [indexOfSelected];

    var totalTransactionQuantityMap = TotalTransactionQuantity(transactionList, selectedButton).getTotalTransactionQuantity();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: DecoratedBox(
        decoration: Decorations.mainPageShowSummaryDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Expanded(
            child: SizedBox(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(totalTransactionQuantityMap['ExpenseTransaction']!.toStringAsFixed(2) +' TL' + '\nToplam Harcama',textAlign: TextAlign.center,))),
          ),
          const SizedBox(
            height: 30,
            child: VerticalDivider(
              color: Colors.black12,
              thickness: 2,
            ),
          ),
          Expanded(
            child: SizedBox(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(totalTransactionQuantityMap['IncomeTransaction']!.toStringAsFixed(2) + ' TL' + '\nToplam Gelir', textAlign: TextAlign.center,))),
          ),
        ]),
      ),
    );
  }
}
