import 'package:expense_tracking_app/constants/constant_values.dart';
import 'package:expense_tracking_app/constants/decorations.dart';
import 'package:expense_tracking_app/pages/statistics_page/statistics_time_range_date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/buttons.dart';
import '../../providers/providers.dart';

class StatisticsPageTimeRangeButtonsWidget extends ConsumerWidget {
  const StatisticsPageTimeRangeButtonsWidget({Key? key}) : super(key: key);


 @override
  Widget build(BuildContext context, WidgetRef ref) {

  String selectedButton = ref.watch(Providers.statisticsPageSelectedButtonProvider);
  ref.watch(Providers.statisticsPageSelectedDateProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: DecoratedBox(
        decoration: Decorations.statisticsPageButtonDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ExpansionTile(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: getStatisticsPageTimeRangeButtons(selectedButton, ref),
            ),
            children: const [
              StatisticsPageTimeRangeDatePickerWidget()],
          ),
        ),
      ),
    );
  }

 List <Widget> getStatisticsPageTimeRangeButtons(selectedButton, WidgetRef ref) {

  List <String> buttonNameList = StatisticsPageButtons.statisticsTimeRangeButtons;

  return buttonNameList.map((e){
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(5),
          primary: selectedButton == e ? Colors.white.withAlpha(200) : ConstantValues.primaryColor,
          backgroundColor: selectedButton == e ? ConstantValues.primaryColor : Colors.transparent
        ),
        onPressed: (){
          ref.read(Providers.statisticsPageSelectedButtonProvider.state).state = e;
        }, 
        child: Text(e)),
    );
  }).toList();
 }

}

