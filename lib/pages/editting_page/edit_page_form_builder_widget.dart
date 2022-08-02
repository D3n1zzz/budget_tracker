import 'package:expense_tracking_app/constants/constant_categories.dart';
import 'package:expense_tracking_app/logics/edit_transaction.dart';
import 'package:expense_tracking_app/logics/validators.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/transaction.dart';
import '../../providers/providers.dart';

class EditPageFormBuilderWidget extends ConsumerStatefulWidget {
 const EditPageFormBuilderWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<EditPageFormBuilderWidget> createState() => _EditPageFormBuilderWidgetState();
}


class _EditPageFormBuilderWidgetState extends ConsumerState<EditPageFormBuilderWidget> {

  late Transaction editingTransaction;
  late List <String> editingCategoryList;
  late String editingTransactionType;
  late DateTime currentDate;
  late DateTime initialDate;

   @override
  void initState() {
    currentDate = DateTime.now();
    editingTransaction = ref.read(Providers.editingTransactionProvider);
    editingTransactionType = editingTransaction.category.categoryType;
    editingCategoryList = getTransactionCategory(editingTransactionType);
    initialDate = DateTime(2022, editingTransaction.date.month - 3);
    super.initState();      
  }

  var editingFormKey = GlobalKey <FormBuilderState> ();
  Validators validator = Validators();

  @override
  Widget build(BuildContext context) {
    
    EditTransaction editTransaction = EditTransaction(editingFormKey, editingTransaction, ref);
    
    return Column(
      children: [
        FormBuilder(
          key: editingFormKey,
          child: Column(
            children: [
              FormBuilderDateTimePicker(
                format: DateFormat('dd-MM-yyyy'),
                name: 'editingDate', 
                inputType: InputType.date,
                initialDate: editingTransaction.date,
                firstDate: initialDate,
                initialValue: editingTransaction.date,
                lastDate: currentDate,
                decoration: InputDecoration(
                  icon: const Icon(Icons.date_range),
                  label: const Text('Tarihi Düzenle'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                ),),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FormBuilderChoiceChip(
                    initialValue: editingTransaction.category.categoryType,
                    onChanged: (value) {
                      setState(() {
                        editingFormKey.currentState!.fields['editingCategory']!.didChange(null);
                        editingCategoryList = getTransactionCategory(value);                     
                      });
                    },
                    decoration: InputDecoration(
                        border:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        label: const Text('Aktarım Türünü Düzenle'),
                        icon: const Icon(Icons.transfer_within_a_station)),
                    alignment: WrapAlignment.spaceAround,
                    name: 'editingTransactionType',
                    options: const [
                      FormBuilderFieldOption(
                          value: 'IncomeTransaction',
                          child: SizedBox(
                              width: 80, child: Center(child: Text('Gelir')))),
                      FormBuilderFieldOption(
                          value: 'ExpenseTransaction',
                          child: SizedBox(
                              width: 80, child: Center(child: Text('Gider')))),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FormBuilderTextField( 
                  validator: (value) => validator.addPageDescriptionValidator(value),
                  initialValue: editingTransaction.description,        
                  name: 'editingDescription',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    icon: const Icon(Icons.description_rounded),
                    label: const Text('Açıklama Düzenle'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FormBuilderTextField(
                  validator: (value) => validator.addPageQuantityValidator(value), 
                  keyboardType: TextInputType.number,
                  initialValue: editingTransaction.value.toString(),        
                  name: 'editingValue',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    icon: const Icon(Icons.production_quantity_limits_outlined),
                    label: const Text('Miktar Düzenle'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FormBuilderDropdown(
                  validator:((value) =>  validator.addPageCategoryValidator(value)),
                  enabled: editingCategoryList.isNotEmpty ? true : false,
                  initialValue: editingTransaction.category.categoryName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                        label: const Text('Kategori Düzenle'),
                        icon: const Icon(Icons.category_outlined)),
                    name: 'editingCategory',
                    items: dropDownMenuItems(editingCategoryList)),
              ),
            editingPageButtons(editTransaction),
            ],
          )),
      ],
    );
  }

  // Getting dropdown menu items from category list.
  List<DropdownMenuItem<String>> dropDownMenuItems(List <String> editingCategoryList) {
    List<DropdownMenuItem<String>> dropDownMenuItemList = editingCategoryList
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList();
    return dropDownMenuItemList;
  }

  // Getting transaction category names according to transaction type and selected type.
  List<String> getTransactionCategory(editingTransactionType) {

    List <TransactionCategory> allTransactionCategory = [...ConstantCategories.constantTransactionCategoryList, 
      ...ref.read(Providers.transactionCategoryListProvider)];

    List <TransactionCategory> sameTypeTransactions = allTransactionCategory.where((element) => element.categoryType == editingTransactionType.toString()).toList();
    return sameTypeTransactions.map((e) => e.categoryName).toList();
    
  }

 Widget editingPageButtons(EditTransaction edit) {

   return Padding(
     padding: const EdgeInsets.only(top: 20),
     child: Row (
       mainAxisAlignment: MainAxisAlignment.end,
       children: [
       TextButton(
         onPressed:() {
           Navigator.of(context).pop();
         } , 
         child: const Text('İptal')),
        const SizedBox(
          width: 30,
        ),
        TextButton(
          onPressed:() {
            if (editingFormKey.currentState!.validate()) {
              edit.editTransaction();
              Navigator.of(context).pop();
            }
          } , 
          child: const Text('Kaydet'))
     ],),
   );

 }
}