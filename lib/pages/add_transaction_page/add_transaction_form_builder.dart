import 'package:expense_tracking_app/constants/constant_values.dart';
import 'package:expense_tracking_app/logics/add_transaction.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:expense_tracking_app/pages/add_transaction_page/add_page_category_selection_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/button_styles.dart';
import '../../logics/validators.dart';
import 'package:intl/intl.dart';
import '../../providers/providers.dart';

// Adding new transaction widget.
class AddPageFormBuilderWidget extends ConsumerStatefulWidget {
  const AddPageFormBuilderWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AddPageFormBuilderWidget> createState() =>
      _AddPageFormBuilderWidgetState();
}

class _AddPageFormBuilderWidgetState extends ConsumerState<AddPageFormBuilderWidget> {

  var formKey = GlobalKey<FormBuilderState>();

  Validators validators = Validators();
  String? transactionType;
  List<String> categoryList = [];

  @override
  Widget build(BuildContext context) {
 
    DateTime currentDate = DateTime.now();
    DateTime initialDate = DateTime(2022, currentDate.month - 3);
    TransactionCategory selectedCategory = ref.watch(Providers.addTrasactionSelectedCategoryProvider);

    return Column(children: [
      FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormBuilderDateTimePicker(
                format: DateFormat('dd-MM-yyyy'),
                validator: (value) =>
                    validators.addPageDatePickerValidator(value),
                name: 'date',
                inputType: InputType.date,
                decoration: const InputDecoration(
                  icon: Icon(Icons.date_range),
                  label: Text('Tarih'),
                ),
                initialValue: currentDate,
                initialDate: currentDate,
                firstDate: initialDate,
                lastDate: currentDate,
              ),
              FormBuilderChoiceChip(
                  onChanged: (value) {
                    setState(() {
                      formKey.currentState!.patchValue({'category': null}); 
                      ref.read(Providers.addTrasactionSelectedCategoryProvider.notifier).deleteSelectedTransactionCategory();
                      if (value != null) {
                        (ref.read(Providers.addPageTransactionTypeProvider.state).state = value.toString());
                      } else {
                      }                
                    });
                  },
                  validator: ((value) =>
                      validators.addPageTransactionTypeValidator(value)),
                  decoration: const InputDecoration(
                      label: Text('Aktarım Türü Seçin'),
                      icon: Icon(Icons.transfer_within_a_station)),
                  alignment: WrapAlignment.spaceAround,
                  name: 'transactionType',
                  options: const [
                    FormBuilderFieldOption(
                        value: 'Income',
                        child: SizedBox(
                            width: 80, child: Center(child: Text('Gelir')))),
                    FormBuilderFieldOption(
                        value: 'Expense',
                        child: SizedBox(
                            width: 80, child: Center(child: Text('Gider')))),
                  ]),
              FormBuilderTextField(
                validator: ((value) =>
                    validators.addPageDescriptionValidator(value)),
                name: 'description',
                decoration: const InputDecoration(
                  icon: Icon(Icons.description_rounded),
                  label: Text('Açıklama'),
                ),
              ),
              FormBuilderTextField(                
                validator: (value) =>
                    validators.addPageQuantityValidator(value),
                keyboardType: TextInputType.number,
                name: 'quantity',
                decoration: const InputDecoration(
                  suffixText: 'TL',
                  icon: Icon(Icons.production_quantity_limits),
                  label: Text('Miktar'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextButton(                                   
                  style: TextButton.styleFrom(
                    primary: Colors.white,                 
                    backgroundColor: ConstantValues.primaryColor.withRed(100), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.all(20),                                        
                  ),
                  onPressed: (){
                    // If transactionType is not selected, then category dialog widget will not appear.
                    if (formKey.currentState!.fields['transactionType']?.value != null ){
                      showCategorySelectionDialog(context);
                    }          
                  }, 
                  child: selectedCategory.categoryName.isEmpty ? const Text('Kategori Seçin') : Text(selectedCategory.categoryName)) ,
              )     
            ],
          )),
      buttons(ref),
    ]);
  }

  Widget buttons(ref) {

    AddTransaction addTransaction = AddTransaction(formKey, ref);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(              
              onPressed: () {
                formKey.currentState!.reset();
                setState(() {
                  transactionType = null;
                });
              },
              child: const Text('Temizle')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                ref.read(Providers.addTrasactionSelectedCategoryProvider.notifier).deleteSelectedTransactionCategory();
                Navigator.of(context).pop();                
              },
              child: const Text('İptal')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              style: ButtonStyles.getAddTransactionPageButtonStyle(),
              onPressed: () {
                TransactionCategory selectedCategory = ref.read(Providers.addTrasactionSelectedCategoryProvider);
                if (selectedCategory.categoryName.isEmpty) {
                  const snackBar =  SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text('Kategori seçin.'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (formKey.currentState!.validate() && selectedCategory.categoryName.isNotEmpty) {
                  // AddTransaction instance will create a new transaction instance and it will add this to Hive and notifier.
                  addTransaction.addTransaction();
                  ref.read(Providers.addTrasactionSelectedCategoryProvider.notifier).deleteSelectedTransactionCategory();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Oluştur')),
        ),
      ],
    );
  }
  
  // Category selection dialog method. Returns dialog widget.
  void showCategorySelectionDialog(BuildContext context) {

    showDialog(
      context: context, 
      builder: ((context) {
        return const AddPageCategorySelectionDialogWidget();
      })
    );
  }
}
