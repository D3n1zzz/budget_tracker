import 'package:expense_tracking_app/logics/statistics_get_date_picker_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class StatisticsPageTimeRangeDatePickerWidget extends ConsumerWidget {
  const StatisticsPageTimeRangeDatePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    String selectedButton = ref.watch(Providers.statisticsPageSelectedButtonProvider);
    ref.watch(Providers.statisticsPageSelectedDateProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: StatisticsGetDatePickerButtons(selectedButton, context, ref).getStatisticsPageDatePickerButtons(),
    );
  }

}
