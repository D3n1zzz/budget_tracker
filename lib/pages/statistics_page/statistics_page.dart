import 'package:expense_tracking_app/pages/statistics_page/statistics_pie_chart_widget.dart';
import 'package:expense_tracking_app/pages/statistics_page/statistics_bar_chart_widget.dart';
import 'package:expense_tracking_app/pages/statistics_page/statistics_time_range_widget.dart';
import 'statistics_page_expense_income_button_widget.dart';
import 'package:flutter/material.dart';

class StatisticsPageWidget extends StatefulWidget {
  const StatisticsPageWidget({Key? key}) : super(key: key);

  @override
  State<StatisticsPageWidget> createState() => _StatisticsPageWidgetState();
}

class _StatisticsPageWidgetState extends State<StatisticsPageWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: const [
            StatisticsPageTimeRangeButtonsWidget(),
            SingleChildScrollView(
              child: StatisticsPageBarChartWidget()),
            StatisticsPageExpenseIncomeButtonWidget(),
            StatisticsPagePieChartWidget(),
          ],
        ),
      ),
    );
  }
}