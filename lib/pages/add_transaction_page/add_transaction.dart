import 'package:expense_tracking_app/pages/add_transaction_page/add_transaction_form_builder.dart';
import 'package:flutter/material.dart';

class AddTransactionFormBuilderWidget extends StatefulWidget {
 const AddTransactionFormBuilderWidget({Key? key}) : super(key: key);

  @override
  State<AddTransactionFormBuilderWidget> createState() =>
      _AddTransactionFormBuilderWidgetState();
}

class _AddTransactionFormBuilderWidgetState
    extends State<AddTransactionFormBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Aktarım Oluştur', style: TextStyle(fontSize: 25),),
              ),
            ),
          ),
          const AddPageFormBuilderWidget(),
        ],
      ),
    );
  }
}
