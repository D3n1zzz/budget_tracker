import 'package:expense_tracking_app/pages/add_transaction_page/add_transaction_page.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Bütçe Takipçisi'),
      elevation: 0,
      actions: [
       IconButton(
         onPressed: () {
           Navigator.of(context).push(
             MaterialPageRoute(builder: (context) => const AddTransactionPage())
           );
         }, 
         icon: const Icon(Icons.add))
      ],
    );
  }
}