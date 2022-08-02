import 'package:expense_tracking_app/constants/constant_categories.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';


class Validators {

  Validators();

  String? addPageDatePickerValidator(value) {
    if (value == null) {
      return 'Tarih girin';
    } else {return null;}
  }

  String? addPageTransactionTypeValidator(value) {
    return value == null ? 'Aktarım türünü seçin' : null; 
  }

  String? addPageDescriptionValidator(value) {
    return value == null ? 'Açıklama giriniz.' : null;
  }

  String? addPageQuantityValidator(value) {
    if (value == null) {
      return 'Miktar giriniz.';
    } else if (double.tryParse(value) == null) {
      return 'Geçerli bir miktar giriniz.';
    }else {return null;}
  }

  String? addPageCategoryValidator(value) {
    return value == null ? 'Kategori seçiniz.' : null;
  }

  String? addCategoryTextInputValidator (String? value, WidgetRef ref) {

    // Reading selected transaction type from provider.
    String newCategoryType = ref.read(Providers.addPageTransactionTypeProvider);
    // Getting existing categories.
    List <TransactionCategory> allCategoryList = [...ConstantCategories.constantTransactionCategoryList, 
      ...ref.read(Providers.transactionCategoryListProvider)];

    if (newCategoryType == 'Income') {
      // Selecting income categories from all category list.
      List <TransactionCategory> allIncomeCategoryList = allCategoryList.where((element) => element.categoryType == 'IncomeTransaction').toList();
      // if there is same name with the existing ones, not validates.
      if (allIncomeCategoryList.any((element) => element.categoryName == value)) {
        return 'Farklı bir kategori ismi giriniz.';
      }
    }else {
      List <TransactionCategory> allExpenseCategoryList = allCategoryList.where((element) => element.categoryType == 'ExpenseTransaction').toList();
      if (allExpenseCategoryList.any((element) => element.categoryName == value)) {
        return 'Farklı bir kategori ismi giriniz.';
      }
    }
      
    if (value == null) {
      return 'Kategori ismi giriniz.';
    }else if (value.length > 50) {
      return 'Daha kısa bir kategori ismi giriniz.';
    }else if (value.trim().isEmpty) {
      return 'Geçerli bir kategori ismi giriniz.';
    }
    
    return null;

  }

  // Validating editing category name. If value equals to other category names, does not validates. 
  //If the value is eqaul to previous name, then validates.
  String? editCategoryTextInputValidator (String? value, WidgetRef ref) {

    TransactionCategory editingCategory = ref.read(Providers.editTransactionCategoryProvider);

    List <TransactionCategory> allTransactionCategoryList = [...ConstantCategories.constantTransactionCategoryList, 
      ...ref.read(Providers.transactionCategoryListProvider)];

    List <TransactionCategory> sameTypeCategoryList = allTransactionCategoryList.where((element) => element.categoryType == editingCategory.categoryType).toList();
    sameTypeCategoryList.removeWhere((element) => element.categoryName == editingCategory.categoryName);
   
    if (sameTypeCategoryList.any((element) => element.categoryName == value)) {
      return 'Farklı bir isim giriniz.';
    }    

    if (value == null) {
      return 'Kategori ismi giriniz.';
    }else if (value.length > 50) {
      return 'Daha kısa bir kategori ismi giriniz.';
    }else if (value.trim().isEmpty) {
      return 'Geçerli bir kategori ismi giriniz.';
    }

    return null;
  }

}