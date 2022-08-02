import 'package:expense_tracking_app/widgets/main_page_widgets/main_show_summary_widget.dart';
import 'package:expense_tracking_app/widgets/main_page_widgets/main_time_range_selection_widget.dart';
import 'package:expense_tracking_app/widgets/main_page_widgets/main_transaction_lists.dart';
import 'package:expense_tracking_app/widgets/sort_transaction_list_widget.dart';
import 'package:flutter/material.dart';

class ExpenseTrackerBody extends StatelessWidget {
  const ExpenseTrackerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MainTimeRangeSelectionWidget(),
        const MainShowSummaryWidget(),
        SortTransactionListWidget(),
        const MainTransactionListWidget(),
      ],
    );
  }
}