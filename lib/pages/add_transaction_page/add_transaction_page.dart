import 'package:expense_tracking_app/pages/add_transaction_page/add_transaction.dart';
import 'package:flutter/material.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: AddTransactionFormBuilderWidget()),
    );
  }
}