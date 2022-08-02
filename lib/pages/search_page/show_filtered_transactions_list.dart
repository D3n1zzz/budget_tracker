import 'package:expense_tracking_app/constants/decorations.dart';
import 'package:expense_tracking_app/logics/delete_transaction.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:expense_tracking_app/pages/editting_page/edit_transaction_page.dart';
import 'package:expense_tracking_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ShowFilteredTransactionListWidget extends ConsumerWidget {
  const ShowFilteredTransactionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    List <Transaction> filteredTransactionList = ref.watch(Providers.filteredTransactionListProvider);

    return SizedBox(
      width: 370,
      height: 300,
      child: DecoratedBox(
        child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: filteredTransactionList.length,
            itemBuilder: ((context, index) {
   
              Transaction transaction = filteredTransactionList[index];
              String transactionType = transaction.category.categoryType;
              var date = DateFormat.yMd('tr_Tr').format(transaction.date);

              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: ExpansionTile(                                    
                  initiallyExpanded: false,                  
                  children: [
                  getEditDeleteButton(transaction, context, ref),
                  ],
                    leading: CircleAvatar(
                    radius: 15,
                    backgroundColor: getAvatarColor(transactionType),
                    child: Text('${(index + 1)}'.toString()),
                  ),
                  title: Text(transaction.description.toString()),
                  subtitle: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(transaction.category.toString()),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(date.toString()),
                      ],
                    ),
                  ),
                  trailing: Text(transaction.value.toStringAsFixed(2) + ' TL'),      
                ),
              );
            })),
        decoration: Decorations.searchFilteredTransactionDecoration),
        );
  }

  Color getAvatarColor(String transactionType) {
    return transactionType == 'IncomeTransaction'
        ? Colors.green
        : Colors.red;
  }

 Row getEditDeleteButton(Transaction transaction, BuildContext context, WidgetRef ref) {

   return Row(
     mainAxisAlignment: MainAxisAlignment.end,
     children: [
       TextButton(
         onPressed: () {
           DeleteTransaction deleteTransaction = DeleteTransaction(transaction, ref);
           deleteTransaction.deleteTransaction();
         }, 
         child: const Text('Sil')),
       TextButton(
         onPressed: (){
           ref.read(Providers.editingTransactionProvider.state).state = transaction;
           Navigator.of(context).push(
             MaterialPageRoute(builder: (context) => const EditTransactionWidget()),
           );
         }, 
         child: const Text('Düzenle')),
     ],);
 }
}