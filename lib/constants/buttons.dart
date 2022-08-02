import '../models/button.dart';

class MainTimeRangeButtons {

  MainTimeRangeButtons();


  List <Button> mainTimeRangeButtonGeneration (){

    var mainTimeRangeButtonNames = MainPageButtons.mainTimeRangeButtonNames;
    
    List <Button> buttons = mainTimeRangeButtonNames.map((e) => Button(buttonName: e, isSelected: false)).toList();
    buttons[0].isSelected = true;

    return buttons;

  }
}

class MainPageButtons {

  MainPageButtons._();

  static final List <String> mainTimeRangeButtonNames = ['Günlük', 'Haftalık', 'Aylık', 'Yıllık', 'Tümü'];

}

class StatisticsPageButtons {

  StatisticsPageButtons._();

  static final List <String> statisticsTimeRangeButtons = ['Haftalık' , 'Aylık' , 'Yıllık'];

  static final List <String> statisticsPagePieChartButtons = ['Gelir', 'Gider'];

}

class SortTransactionListButtons {

  SortTransactionListButtons();

  final List <String> sortTransactionListExpenseIncome = ['Önce \nGelirler', 'Önce \nGiderler'];

  final List <String> sortTransactionListOptions = ['Tarihe \nGöre', 'Miktara \nGöre'];

  List <SortingButtonExpenseIncome> getSortingExpenseIncomeButtons () {

    return sortTransactionListExpenseIncome.map((e) => SortingButtonExpenseIncome(e, false)).toList();

  }

  List <SortingOptionButton> getSortingOptionButtons () {

    return sortTransactionListOptions.map((e) => SortingOptionButton(e, 'passive')).toList();

  }

}
