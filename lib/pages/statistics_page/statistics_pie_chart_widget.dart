import 'package:expense_tracking_app/logics/statistics_filtered_transaction.dart';
import 'package:expense_tracking_app/logics/statistics_pie_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/transaction.dart';
import '../../providers/providers.dart';

class StatisticsPagePieChartWidget extends ConsumerWidget {
  const StatisticsPagePieChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // StatisticsPage which button is selected? Buttons are 'Günlük', 'Haftalık', ...
    ref.watch(Providers.statisticsPageSelectedButtonProvider);
    // StatisticsPage which date is selected? CupertineSelection buttons.
    ref.watch(Providers.statisticsPageSelectedDateProvider);
    // Watches for new transactions. If new transaction is added, then automatically updates.
    ref.watch(Providers.transactionListProvider);
    // Checks for which button is selected. 'Gelir' or 'Gider'
    String selectedPieChartButton = ref.watch(Providers.statisticsPageSelectedPieChartButton);

    Map <int, List<Transaction>> statisticsPageFilteredTransactionMap = StatisticsPageFilterTransactions(ref).filterTransactions();
    StatisticsPagePieChartData pieChartData = StatisticsPagePieChartData(statisticsPageFilteredTransactionMap, ref);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black45
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
                child: SizedBox(            
                  height: 300,
                  width: 500,
                  child: PieChart(
                    PieChartData(                  
                        centerSpaceRadius: pieChartData.getPieChartCenterRadius(),                
                      sections: pieChartData.getPieChartSections(selectedPieChartButton),
                    )
                  ),
                ),
              ),        
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: pieChartData.getPieChartColorLegends(),
              )
            ],
          ),
        ),
      ),
    );
  }
}