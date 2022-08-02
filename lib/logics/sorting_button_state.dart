import 'package:expense_tracking_app/models/button.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SortingButtonState {

  WidgetRef ref;

  SortingButtonState(this.ref);

  void changeExpenseIncomeButtonState (SortingButtonExpenseIncome pressedButton) {

    List <SortingButtonExpenseIncome> sortingExpenseIncomeList = ref.read(Providers.sortingButtonExpenseIncomeProvider);

    // Checks whether there is any pressed button.
    if (sortingExpenseIncomeList.any((element) => element.isSelected == true)) {
      // Checks whether the button is selected before
      if (sortingExpenseIncomeList.firstWhere((element) => element == pressedButton).isSelected) {
        // If the button selected before, then isSelected is set to false.
        sortingExpenseIncomeList.firstWhere((element) => element == pressedButton).isSelected = false;
        // If the button is not selected before;
      }else {
        // Iterates all buttons and turne other buttons isSelected value to false.
        // Makes pressed button isSelected value to true.
        for (SortingButtonExpenseIncome button in sortingExpenseIncomeList) {
          if (button != pressedButton) {
            button.isSelected = false;
          }else {
            button.isSelected = true;
          }
        }
      }
    }else {
      // If there are no pressed button then, if makes isSelected to true.
      sortingExpenseIncomeList.firstWhere((element) => element == pressedButton).isSelected = true;
    }
    // Updates notifier and changes states the widgets that listens that notifier.
    ref.read(Providers.sortingButtonExpenseIncomeProvider.notifier).updateSortingExpenseIncomeButtonStates();
  }

  void changeSortingOptionButtonState (SortingOptionButton pressedButton) {

    List <SortingOptionButton> sortingOptionButtonList = ref.read(Providers.sortingOptionButtonStateNotifier);
    // Finding button from notifier.
    SortingOptionButton button = sortingOptionButtonList.firstWhere((element) => element == pressedButton);

    if (sortingOptionButtonList.any((element) => element.buttonState != 'passive')) {
      for (SortingOptionButton button in sortingOptionButtonList) {
        if (button != pressedButton) {
          button.buttonState = 'passive';
        }
      }
    }

    switch (button.buttonState) {

      case 'passive':
        button.buttonState = 'increasing';
        break;
      case 'increasing':
        button.buttonState = 'decreasing';
        break;
      case 'decreasing':
        button.buttonState = 'passive';
    }
    ref.read(Providers.sortingOptionButtonStateNotifier.notifier).updateSortingOptionButtonStates();    
  }

}