import 'package:expense_tracking_app/pages/editting_page/edit_transaction_body_widget.dart';
import 'package:flutter/material.dart';

class EditTransactionWidget extends StatelessWidget {
  const EditTransactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: EditTransactionBodyWidget(),
      ),
    );
  }
}