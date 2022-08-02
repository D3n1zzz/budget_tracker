import 'package:expense_tracking_app/logics/delete_transaction_category.dart';
import 'package:expense_tracking_app/logics/edit_transaction_category.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/button_styles.dart';
import '../../logics/validators.dart';
import '../../providers/providers.dart';
import 'add_page_category_color_picker.dart';

class AddPageEditCategoryWidget extends ConsumerWidget {
  AddPageEditCategoryWidget({Key? key}) : super(key: key);

  final formKeyEditing = GlobalKey <FormBuilderState> ();
  late final  TransactionCategory editingCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    editingCategory = ref.watch(Providers.editTransactionCategoryProvider);
    late EditTransactionCategory editTransactionCategory;
    late DeleteTransactionCategory deleteTransactionCategory;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: FormBuilder(
            key: formKeyEditing,
            child: FormBuilderTextField(              
              validator: ((value) => Validators().editCategoryTextInputValidator(value, ref)),
              name: 'editingCategoryTextField',
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                fillColor: Colors.white,
                filled: true
              ),
              initialValue: editingCategory.categoryName,                          
            )),
        ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  style: ButtonStyles.getEditingCategoryButtonStyle(),
                  onPressed: () {
                    deleteTransactionCategory = DeleteTransactionCategory(ref);
                    deleteTransactionCategory.deleteTransactionCategory();
                  }, 
                  child: const Text('Kategoriyi Sil')),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextButton(
                  style: ButtonStyles.getEditingCategoryButtonStyle(),
                  onPressed: () {
                    // If editing is canceled, then updates provider to dummy transaction category. Does not change anything.
                    ref.read(Providers.editTransactionCategoryProvider.notifier).editingDoneTransactionCategory();
                  }, 
                  child: const Text('İptal')),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  width: 70,
                  child: AddCategoryButtonColorPickerWidget()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 1),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    if (formKeyEditing.currentState!.validate()) {
                      // If form validated, EditTransactionCategory class instance will update category in notifier and Hive.
                      editTransactionCategory = EditTransactionCategory(formKeyEditing, ref);
                      editTransactionCategory.editTransactionCategory();
                    }
                  }, 
                  icon: const Icon(Icons.arrow_forward_ios)),
              ),              
            ],
          )
      ],
    );
  }
}