import 'package:expense_tracking_app/models/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/button_styles.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../providers/providers.dart';

class AddCategoryButtonColorPickerWidget extends ConsumerStatefulWidget {
 const AddCategoryButtonColorPickerWidget({Key? key}) : super(key: key);
  @override
  ConsumerState<AddCategoryButtonColorPickerWidget> createState() => _AddPageCategoryColorPickerWidgetState();
}

class _AddPageCategoryColorPickerWidgetState extends ConsumerState<AddCategoryButtonColorPickerWidget> {
  // Defult selected category color.
  late Color selectedCategoryColor;
  late bool isCategoryEditing;

  @override
  Widget build(BuildContext context) {

    TransactionCategory editingTransactionCategory = ref.read(Providers.editTransactionCategoryProvider);
    isCategoryEditing = editingTransactionCategory.categoryName.isNotEmpty;
    selectedCategoryColor = editingTransactionCategory.categoryName.isEmpty ? Colors.red : Color(editingTransactionCategory.categoryColorValue);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: TextButton(
          onPressed: () {
            pickCategoryColor(context, ref);
          },
          style: ButtonStyles.getAddCategoryColorPickerButtonStyle(ref),
          child: isCategoryEditing ? const Text('') : const Text('Kategori Rengi'),
        ),
      ),
    );
  }
  
  void pickCategoryColor(BuildContext context, WidgetRef ref) {

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          content: Column(
            children: [
              buildColorPicker(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (isCategoryEditing) {
                    ref.read(Providers.editTransactionCategoryColorValueProvider.state).state = selectedCategoryColor.value;
                  }else {
                    // Writing provider new selected color when button is pressed.
                    ref.read(Providers.addTransactionCategoryColorValueProvider.state).state = selectedCategoryColor.value;
                  }                  
                }, 
                child: const Text('Onayla'))
            ],
          ),
        );
      });
  }
  
  Widget buildColorPicker() {

    return ColorPicker(
      enableAlpha: false,
      labelTypes: const [],
      pickerColor: selectedCategoryColor,
      onColorChanged: (color) {
        selectedCategoryColor = color;
      },
    );
  }
}