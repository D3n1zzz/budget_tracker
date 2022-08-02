import 'package:expense_tracking_app/pages/add_transaction_page/add_transaction_page.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
          return const AddTransactionPage();
        })));
      },
      child: const Icon (Icons.add),
    );
  }
}