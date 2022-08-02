import 'package:hive/hive.dart';
part 'transaction_category.g.dart';


@HiveType(typeId: 2)
class TransactionCategory {

  @HiveField(0)
  String categoryName;
  @HiveField(1)
  // There are two types of transaction. 1- IncomeTransaction, 2- ExpenseTransaction
  String categoryType;
  @HiveField(2)
  int categoryColorValue;

  TransactionCategory(this.categoryName, this.categoryType, this.categoryColorValue);

  @override
  String toString() {
    
    return categoryName;
  }
}
