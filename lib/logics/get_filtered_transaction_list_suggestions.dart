import 'package:expense_tracking_app/models/transaction.dart';

class GetTransactionSuggestions {

  GetTransactionSuggestions._();

  static List<Transaction> getTransactionSuggestion(List<Transaction> transactionList, String query) {

    if (query.isNotEmpty) {
      return transactionList.where((element) {
        final transactionDesLower = element.description.toLowerCase();
        final queryLower = query.toLowerCase();

        return transactionDesLower.contains(queryLower);
      }).toList();
    } else {
      return const Iterable<Transaction> .empty().toList();
    }
  }
}
