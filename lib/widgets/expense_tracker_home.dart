import 'package:expense_tracking_app/pages/search_page/search_page.dart';
import 'package:expense_tracking_app/pages/statistics_page/statistics_page.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:expense_tracking_app/widgets/appbar.dart';
import 'package:expense_tracking_app/widgets/expense_tracker_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'bottom_navigation_bar.dart';

class ExpenseTrackerHome extends ConsumerWidget {
  ExpenseTrackerHome({Key? key}) : super(key: key);

  final List <Widget> pages = [
    const SingleChildScrollView(child: ExpenseTrackerBody()),
    const SearchPageWidget(),
    const StatisticsPageWidget(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    int currentPageIndex = ref.watch(Providers.bottomNavBarIndexProvider);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarWidget()),
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: pages[currentPageIndex],
      // floatingActionButton: const FloatingActionButtonWidget(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );

  }
}