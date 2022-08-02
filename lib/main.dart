import 'package:expense_tracking_app/constants/constant_values.dart';
import 'package:expense_tracking_app/constants/material_color.dart';
import 'package:expense_tracking_app/constants/themes.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:expense_tracking_app/widgets/expense_tracker_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();

  // **********When changing the class variables, below commands should be used, 
  //***********because corrupted data will interfere hive.

  // await Hive.deleteBoxFromDisk('transactionCategory');
  // await Hive.deleteBoxFromDisk('transaction');

  Hive
      ..registerAdapter(TransactionCategoryAdapter())
      ..registerAdapter(TransactionAdapter());
  await Hive.openBox <TransactionCategory> ('transactionCategory');
  await Hive.openBox <Transaction> ('transaction');
  // Hive.box<Transaction>('transaction').clear();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: ExpenseTrackerApp()));
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: const [
       Locale('tr')
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: CustomMaterialColor().createMaterialColor(ConstantValues.primaryColor),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle (
          )
        ),
        fontFamily: ConstantValues.fontFamily,
        textButtonTheme: ThemeConstants.textButtonThemeData,
      ),
      home: ExpenseTrackerHome(),
    );
  }
}