import 'package:expense_tracking_app/constants/constant_categories.dart';
import 'package:expense_tracking_app/constants/constant_values.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import 'add_page_add_category_button_text_input.dart';


// Category selection dialog UI widget.
class AddPageCategorySelectionDialogWidget extends ConsumerWidget {
  const AddPageCategorySelectionDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Listens for selected category type in the formbuilder widget - ChoiceChip Widget.
    String categoryType = ref.watch(Providers.addPageTransactionTypeProvider);
    // Gets constant and user created categories.
    List <TransactionCategory> categoryList = [...ConstantCategories.constantTransactionCategoryList, 
      ...ref.watch(Providers.transactionCategoryListProvider)];
    
    return Dialog(      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      insetPadding: const EdgeInsets.all(30),
      backgroundColor: ConstantValues.primaryColor.withOpacity(0.4),
      child: Column(
        children: [ 
          Expanded(
            child: GridView.count(
              childAspectRatio: 2,
              children: getGridCategorySelectionList(categoryList, categoryType, ref, context),
              crossAxisCount: 2,),
          ),
            const AddCategoryButtonTextInputWidget(),
        ]
      ),      
    );
  }
  
  List <Widget> getGridCategorySelectionList(List <TransactionCategory> categoryList, String categoryType, WidgetRef ref, BuildContext context) {

    // Creating selection list according to selected transaction type.
    List <TransactionCategory> categoryListAccordingToSelectedType = List.empty();

    if (categoryType == 'Income') {
      categoryListAccordingToSelectedType = categoryList.where((element) => element.categoryType == 'IncomeTransaction').toList();

    } else {
      categoryListAccordingToSelectedType = categoryList.where((element) => element.categoryType == 'ExpenseTransaction').toList();
    }

    return categoryListAccordingToSelectedType.map((e){

      bool isUserCategory = ref.read(Providers.transactionCategoryListProvider).any((element) => element.categoryName == e.categoryName);

      return Padding(
        padding: const EdgeInsets.all(8),
        child: TextButton(
          style: TextButton.styleFrom(    
            backgroundColor: isUserCategory ? Color(e.categoryColorValue) : ConstantValues.primaryColor,
            primary: Colors.white,
            shape: RoundedRectangleBorder(              
              borderRadius: BorderRadius.circular(50),
              side: const BorderSide(
                color: Colors.white,
              )
            )
          ),
          child: Text(e.categoryName,textAlign: TextAlign.center),
          onPressed: () {
            ref.read(Providers.addTrasactionSelectedCategoryProvider.notifier).changeSelectedTransactionCategory(e);
            Navigator.of(context).pop();
          },
          onLongPress: () {   
            // If the category user created, then writes it to provider.
            if (isUserCategory) {
              ref.read(Providers.editTransactionCategoryProvider.notifier).editTransactionCategory(e);
              ref.read(Providers.editTransactionCategoryColorValueProvider.state).state = e.categoryColorValue;              
            }
          },
        ),
      );

    }).toList();       

  }
   

}