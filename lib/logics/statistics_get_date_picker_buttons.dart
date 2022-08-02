import 'package:expense_tracking_app/constants/constant_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class StatisticsGetDatePickerButtons {
  String selectedButton;
  BuildContext context;
  WidgetRef ref;
  int selectedWeek = 0, selectedMonth = 0, selectedYear = 0;

  StatisticsGetDatePickerButtons(this.selectedButton, this.context, this.ref);

  List<Widget> getStatisticsPageDatePickerButtons() {

    List <int> selectedDateList = ref.read(Providers.statisticsPageSelectedDateProvider);
    selectedWeek = selectedDateList[0];
    selectedMonth = selectedDateList[1];
    selectedYear = selectedDateList[2];

    Map<String, int> initialValues = {
      'initialWeek': selectedWeek,
      'initialMonth': selectedMonth,
      'initialYear': selectedYear
    };

    if (selectedButton == 'Haftalık') {
      List<Widget> buttonList = initialValues.entries.map((e) {
        
        return getButtonWidget(e.value, e.key);

      }).toList();

      return buttonList;

    } else if (selectedButton == 'Aylık') {

      initialValues.remove('initialWeek');
      List<Widget> buttonList = initialValues.entries.map((e) {
        return getButtonWidget(e.value, e.key);
    
      }).toList();

      return buttonList;


    } else {

      initialValues.remove('initialWeek');
      initialValues.remove('initialMonth');
      List<Widget> buttonList = initialValues.entries.map((e) {
        return getButtonWidget(e.value, e.key); 
      }).toList();

      return buttonList;
    }
  }

  Widget getButtonWidget(int value, String key) {

    return Padding(
          padding: const EdgeInsets.all(5),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: ConstantValues.primaryColor.withOpacity(0.2),
            ),
            child: TextButton(
                onPressed: () {
                  showCupertinoModalPopup(                    
                    context: context, 
                    builder: (context) => CupertinoActionSheet(
                      actions: [
                        cupertinoActionBuilder(value, key),
                        getCupertinoPickerButtons(),
                      ],
                    ));
                },
                child: key == 'initialMonth' ? Text('${ConstantValues.monthNamesMap[value]}') : Text(value.toString() + getCompleterString(key))),
          ),
    );

  }
  String getCompleterString(value) {

    String completerString = '';

        switch (value.toString()) {
          case 'initialWeek':
            completerString = '.Hafta';
            break;
          case 'initialMonth':
            completerString = '.Ay';
            break;
        }
    return completerString;
  }

 Widget cupertinoActionBuilder(int value, String key) {

   late FixedExtentScrollController scrollController;

   if(key == 'initialYear') {
     scrollController = FixedExtentScrollController(initialItem: DateTime.now().year - value);
   }else {
     scrollController = FixedExtentScrollController(initialItem: value - 1);
   }

   return SizedBox(
     height: 250,
     child: CupertinoPicker( 
       scrollController: scrollController,      
       backgroundColor: ConstantValues.primaryColor.withAlpha(30),
       itemExtent: 64,
       children: getCupertinoPickerList(value, key), 
        
       onSelectedItemChanged: (value) {
          writeValueAccordingToSelection(value, key);
          List <int> selectedDateValue = [selectedWeek, selectedMonth, selectedYear];
          ref.read(Providers.statisticsPageSelectedDateProvider.state).state = [...selectedDateValue];
       },
     ),
   );

 }

 List <Widget> getCupertinoPickerList (int value, String key) {

   late List <int> yearList;
   late List <int> monthList;
   late List <int> weekList;

   switch(key){

    case 'initialYear':
      yearList = List.generate(2, (index) => DateTime.now().year - index);
      return yearList.map((e) => Center(child: Text(e.toString()))).toList();
    case 'initialMonth':
      monthList = List.generate(12, (index) => index + 1);
      return monthList.map((e) => Center(child: Text(ConstantValues.monthNamesMap[e]!))).toList();
    case 'initialWeek':
      weekList = List.generate(4, (index) => index + 1);  
      return weekList.map((e) => Center(child: Text(e.toString() + ' .Hafta'))).toList();  
   }

   return [];
 }

  Widget getCupertinoPickerButtons() {

  return TextButton(
    onPressed: () {
      Navigator.of(context).pop();
    }, 
    child: const Text('Kapat'));
  }

  void writeValueAccordingToSelection(int value, String key) {

    switch (key) {

      case 'initialWeek':
        selectedWeek = value + 1;
        break;
      case 'initialMonth':
        selectedMonth = value + 1;
        break;
      case 'initialYear':
         selectedYear = DateTime.now().year - value;
  
      break;
    }

  }
}
