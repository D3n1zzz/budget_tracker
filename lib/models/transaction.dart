import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:hive/hive.dart';
part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction {

  @HiveField(0)
  int id;
  @HiveField(1)
  double value;
  @HiveField(2)
  String description;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  TransactionCategory category;

  Transaction(this.id, this.value, this.description, this.date, this.category);

  @override
  String toString() {

    return id.toString() + ' ' + description;
  }
}

