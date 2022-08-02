import 'package:expense_tracking_app/constants/buttons.dart';
import 'package:expense_tracking_app/constants/constant_values.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticsPageExpenseIncomeButtonWidget extends ConsumerWidget {
  const StatisticsPageExpenseIncomeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    String selectedPieChartButton = ref.watch(Providers.statisticsPageSelectedPieChartButton);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: ConstantValues.primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row (
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: getPieChartButton(selectedPieChartButton, ref),
        ),
      ),
    );
  }
  

 
 List <Widget> getPieChartButton(String selectedPieChartButton, WidgetRef ref) {

   List <String> buttonNames = StatisticsPageButtons.statisticsPagePieChartButtons;

   List <Widget> buttonWidgets = buttonNames.map((e) {

     late bool isSelected;
     selectedPieChartButton == e ? isSelected = true : isSelected = false;

     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20),
       child: TextButton(       
         style: TextButton.styleFrom(
           padding: const EdgeInsets.symmetric(horizontal: 30),
           primary: isSelected ? Colors.white : ConstantValues.primaryColor,
           backgroundColor: isSelected ? ConstantValues.primaryColor : Colors.transparent,
         ),
         onPressed: () {
           ref.read(Providers.statisticsPageSelectedPieChartButton.state).state = e;
         },
     
        child: Text(e)),
     );
   }).toList();
   return buttonWidgets;   
 }

}