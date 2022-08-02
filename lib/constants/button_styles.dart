import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import 'constant_values.dart';

class ButtonStyles {

  ButtonStyles._();

  static ButtonStyle getEditingCategoryButtonStyle() {

   return TextButton.styleFrom(
     backgroundColor: ConstantValues.primaryColor.withRed(100),
     shape: RoundedRectangleBorder(
       side: const BorderSide(
         color: Colors.white
       ),
       borderRadius: BorderRadius.circular(50),       
     ),
     padding: const EdgeInsets.all(10),
     primary: Colors.white,     
   );
 }

 static ButtonStyle getAddCategoryColorPickerButtonStyle(WidgetRef ref){

   TransactionCategory editingTransactionCategory = ref.watch(Providers.editTransactionCategoryProvider);
   
   return TextButton.styleFrom(
     backgroundColor: editingTransactionCategory.categoryName.isEmpty ? Color(ref.watch(Providers.addTransactionCategoryColorValueProvider)) : Color(ref.watch(Providers.editTransactionCategoryColorValueProvider)),
     shape: RoundedRectangleBorder(
       side: const BorderSide(
         color: Colors.white
       ),
       borderRadius: BorderRadius.circular(100),
     ),
     padding: const EdgeInsets.all(10),
     primary: Colors.white
   );
 } 

  static getAddTransactionPageButtonStyle () {

    return TextButton.styleFrom(
      primary: ConstantValues.primaryColor,
      backgroundColor: ConstantValues.primaryColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(        
        borderRadius: BorderRadius.circular(100)
      )
    ); 


  }


}