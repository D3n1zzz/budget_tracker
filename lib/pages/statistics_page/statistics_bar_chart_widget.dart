import 'package:expense_tracking_app/constants/constant_values.dart';
import 'package:expense_tracking_app/logics/statistics_filtered_transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../logics/statistics_page_bar_chart_data.dart';
import '../../models/transaction.dart';
import '../../providers/providers.dart';

class StatisticsPageBarChartWidget extends ConsumerWidget {
  const StatisticsPageBarChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Map <int,List<Transaction>> statisticsFilteredTransactionMap = StatisticsPageFilterTransactions(ref).filterTransactions();
    String selectedButton = ref.watch(Providers.statisticsPageSelectedButtonProvider);
    List <int> selectedDateRange = ref.watch(Providers.statisticsPageSelectedDateProvider);
    ref.watch(Providers.transactionListProvider);
    ref.watch(Providers.editingSuccessfullProvider);
    StatisticsBarChartData barChartData = StatisticsBarChartData(statisticsFilteredTransactionMap, ref);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 600,
          height: 500,
          child: Stack(
            children: [                          
                Card(
                color: ConstantValues.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
                  child: BarChart(              
                    BarChartData( 
                      maxY: barChartData.getLeftTitleInterval() * 11,    
                      gridData: FlGridData(
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.white.withOpacity(0.5),
                            strokeWidth: 2,
                            dashArray: [5,5]
                          );
                        },
                      ),                   
                      titlesData: barChartData.getTitlesData(),
                      alignment: BarChartAlignment.spaceAround,
                      // groupsSpace: barChartData.getGroupSpace(),
                      barGroups: barChartData.getBarChartGroupData(),
                    )
                  ),
                ),
                ),
            Positioned(
              top: 10,
              left: 30,
              child: getTitleText(selectedButton, selectedDateRange)),  
          ]
          )
        ),
      ),
    );    
  }
  
 Widget getTitleText(String selectedButton, List <int> selectedDateRange) {

   int selectedMonth = selectedDateRange [1];
   int selectedYear = selectedDateRange[2];
   int selectedWeek = selectedDateRange[0];

   TextStyle barChartHeaderTextStyle = TextStyle(
     fontSize: 20,
     fontWeight: FontWeight.w500,
     color: Colors.white,
     fontFamily: ConstantValues.fontFamily,
   );

   switch(selectedButton) {

    case 'Haftalık':
      return Text('${ConstantValues.monthNamesMap[selectedMonth]} $selectedYear Yılı $selectedWeek. Haftası Gelir - Gider Tablosu', style: barChartHeaderTextStyle,);
    case 'Aylık':
      return Text('${ConstantValues.monthNamesMap[selectedMonth]} $selectedYear Yılı Gelir - Gider Tablosu', style: barChartHeaderTextStyle,);
    case 'Yıllık':
      return Text('$selectedYear Yılı Gelir - Gider Tablosu', style: barChartHeaderTextStyle,); 
   }
   return const Text('Hata');
  }


}
