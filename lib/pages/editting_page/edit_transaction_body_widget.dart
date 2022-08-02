import 'package:flutter/material.dart';

import 'edit_page_form_builder_widget.dart';

class EditTransactionBodyWidget extends StatelessWidget {
  const EditTransactionBodyWidget({Key? key}) : super(key: key);

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
                child: Text('Aktarım Düzenle', style: TextStyle(fontSize: 25),),
              ),
            ),
          ),
          const EditPageFormBuilderWidget(),
        ],
      ),
    );
  }
}