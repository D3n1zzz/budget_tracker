import 'package:expense_tracking_app/constants/constant_values.dart';
import 'package:expense_tracking_app/logics/sorting_button_state.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/text_styles.dart';
import '../models/button.dart';

// ignore: must_be_immutable
class SortTransactionListWidget extends ConsumerWidget {

SortTransactionListWidget({Key? key}) : super(key: key);

  late List <SortingButtonExpenseIncome> sortingButtonExpenseIncomeList;
  late List <SortingOptionButton> sortingOptionButtonList;
  late SortingButtonState buttonStateUpdate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    sortingButtonExpenseIncomeList = ref.watch(Providers.sortingButtonExpenseIncomeProvider);
    sortingOptionButtonList = ref.watch(Providers.sortingOptionButtonStateNotifier);

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [...getSortTransactionExpenseIncome(ref), ...getSortTransactionOptions(ref)],
      ),
    );
  }

  // This buttons can be active or passive. If one of the buttons are selected, the other one will be passive.
  List <Widget> getSortTransactionExpenseIncome (WidgetRef ref) {

    return sortingButtonExpenseIncomeList.map((e) {
        return Row(
          children: [
            TextButton(
              onPressed: (){
                buttonStateUpdate = SortingButtonState(ref);
                buttonStateUpdate.changeExpenseIncomeButtonState(e);
              }, 
              child: Text(e.buttonName , textAlign: TextAlign.center, style: TextStyles().getSortTransactionListButtonTextStyle())),
              Icon(
                Icons.circle, 
                size: 15,
                color: e.isSelected ? ConstantValues.primaryColor : ConstantValues.primaryColor.withOpacity(0.2),
                )
        ]);
      }).toList();
  }

  // This buttons have 3 states. 'decreasing', 'increasing' and 'passive' states. All of them are independent from each other.
  List <Widget> getSortTransactionOptions(WidgetRef ref) {

    return sortingOptionButtonList.map((e) {
      return Row(
        children: [
          TextButton(
            onPressed: () {
              buttonStateUpdate = SortingButtonState(ref);
              buttonStateUpdate.changeSortingOptionButtonState(e);
            }, 
            child: Text(e.buttonName, style:  TextStyles().getSortTransactionListButtonTextStyle(),)),
          Column(
            children: [
               Icon(
                Icons.keyboard_arrow_up,
                color: getSortingOptionButtonIconColor(e, 'increasing'),
                ),
               Icon(
                 Icons.keyboard_arrow_down,
                 color:  getSortingOptionButtonIconColor(e, 'decreasing'),
                 ),
            ],
          )
        ],
      );
    }).toList();
  }

  Color getSortingOptionButtonIconColor (SortingOptionButton button, String iconName) {

    if (button.buttonState == iconName) {
      return ConstantValues.primaryColor;
    }else {
      return ConstantValues.primaryColor.withOpacity(0.4);
    }

  }
}