import 'package:expense_tracking_app/constants/constant_values.dart';
import 'package:expense_tracking_app/constants/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../constants/decorations.dart';

class MainTimeRangeSelectionWidget extends ConsumerWidget {
  const MainTimeRangeSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Center(
        child: DecoratedBox(
          decoration: Decorations.mainPageButtonDecoration,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: mainTimeRangeButtons(ref),
            ),
          ),
        ),
      ),
    );
  }

  List <Widget> mainTimeRangeButtons(WidgetRef ref) {
    
    List <String> buttonNames = MainPageButtons.mainTimeRangeButtonNames;
    ref.watch(Providers.selectedButtonProvider);

    return buttonNames.map((e) {
      bool isSelected = ref.read(Providers.selectedButtonProvider.notifier).isSelected(e);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: isSelected ? Colors.white : ConstantValues.primaryColor,
            backgroundColor: isSelected ? ConstantValues.primaryColor : Colors.transparent,
          ),
          onPressed: (){
            ref.read(Providers.selectedButtonProvider.notifier).buttonSelect(e);
          }, 
          child: Text(e)),
      );
    }).toList();

  }
}