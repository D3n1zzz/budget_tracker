import 'package:expense_tracking_app/logics/add_transaction_category.dart';
import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:expense_tracking_app/pages/add_transaction_page/add_page_category_color_picker.dart';
import 'package:expense_tracking_app/pages/add_transaction_page/add_page_edit_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/constant_values.dart';
import '../../logics/validators.dart';
import '../../providers/providers.dart';

class AddCategoryButtonTextInputWidget extends ConsumerStatefulWidget {
  const AddCategoryButtonTextInputWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AddCategoryButtonTextInputWidget> createState() => _AddCategoryButtonTextInputWidgetState();
}

class _AddCategoryButtonTextInputWidgetState extends ConsumerState<AddCategoryButtonTextInputWidget> {

  var formKey = GlobalKey <FormBuilderState> ();
  var formKeyEditing = GlobalKey <FormBuilderState> ();
  bool showAddCategoryTextInput = false;
  late TransactionCategory editingCategory;

  @override
  Widget build(BuildContext context) {

    // if editing category name is not empty, returns edit category formbuilder widgets.
    editingCategory = ref.watch(Providers.editTransactionCategoryProvider);
    String isEditingCategorySelected = editingCategory.categoryName;

    if (isEditingCategorySelected.isEmpty && showAddCategoryTextInput == false) {
      return getAddCategoryButton();
    } else if (isEditingCategorySelected.isNotEmpty) {
      return AddPageEditCategoryWidget();
    } else {
      return getAddCategoryTextInput(ref);
    }

  }

  Widget getAddCategoryButton() {

    return Padding(
        padding: const EdgeInsets.all(30),
        child: TextButton.icon(          
          style: TextButton.styleFrom(  
            padding: const EdgeInsets.all(20),     
            backgroundColor: ConstantValues.primaryColor.withRed(100),
            primary: Colors.white,
            shape: RoundedRectangleBorder(              
              borderRadius: BorderRadius.circular(100),
              side: const BorderSide(
                color: Colors.white,
              )
            )
          ),
          icon: const Icon(Icons.add),
          label: const Text('Kategori Ekle'),
          onPressed: () {
            setState(() {
              showAddCategoryTextInput = true;
            });
          },          
        ),
      );

  }
  
 Widget getAddCategoryTextInput(WidgetRef ref) {

   return Column(
     children: [
       Row(
       children: [
         Expanded(
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
             child: FormBuilder( 
              key: formKey,    
              child: FormBuilderTextField(
                validator: ((value) => Validators().addCategoryTextInputValidator(value, ref)),        
               decoration: InputDecoration(
                 hintText: 'Kategori İsmi',
                 filled: true,
                 fillColor: Colors.white,
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(50),
                 )
               ),
               name: 'addCategoryTextField')),
           ),
         ),
         IconButton(
           onPressed: () {
             setState(() {
               showAddCategoryTextInput = false;
             });
           }, 
           icon: const Icon(Icons.cancel_outlined), iconSize: 25, color: Colors.white,),
          IconButton(
            onPressed: () {            
              if (formKey.currentState!.validate()) { 
                // Creating new category instance and adding it to Hive and notifier
                AddTransactionCategory(formKey, ref).addNewCategory();  
                setState(() {
                  showAddCategoryTextInput = false;
                });
              }
              
            }, 
            icon: const Icon(Icons.arrow_forward_ios), iconSize: 30, color: Colors.white,),
        ]
     ),
      const AddCategoryButtonColorPickerWidget(),
    ]
   );


 } 

}
