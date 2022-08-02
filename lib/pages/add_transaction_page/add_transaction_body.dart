import 'package:flutter/material.dart';
import '../../constants/constant_categories.dart';
import '../../constants/decorations.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddTransactionBody extends StatefulWidget {
  const AddTransactionBody({Key? key}) : super(key: key);

  @override
  State<AddTransactionBody> createState() => _AddTransactionBodyState();
}

class _AddTransactionBodyState extends State<AddTransactionBody> {
  String? dropDownValue;
  int? radioValue;
  DateTime? date;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateTime firstDate = DateTime(2022, currentDate.month - 3);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Center(
        child: FormBuilder(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              children: [
                TextButton.icon(
                    onPressed: () {
                      datePickerMethot(context, currentDate, firstDate);
                    },
                    icon: const Icon(Icons.date_range_outlined),
                    label: textPicker(date)),
                Row(children: [
                  FormBuilderRadioGroup(
                    name: 'TransactionType', 
                    options: const [
                    FormBuilderFieldOption(
                      value: 'Income',
                      child: Text('Gelir'),
                    ),
                    FormBuilderFieldOption(
                      value: 'Expense',
                      child: Text('Gider'),
                      )
                  ])
                ]),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: FormBuilderTextField(
                    name: 'description',
                    keyboardType: TextInputType.text,
                    decoration: Decorations.addPageDescriptionInputDecoration,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: FormBuilderTextField(
                    name: 'quantity',
                    keyboardType: TextInputType.number,
                    decoration: Decorations.addPageQuantityInputDecoration,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: Decorations.addPageDropDownMenuBoxDecoration,
                    child: FormBuilderDropdown <String>(
                        name: 'category',
                        elevation: 0,
                        isExpanded: true,
                        hint: const Text('Kategori'),
                        items: dropDownMenuItems(),
                        onChanged: (value) {
                          setState(() {
                            dropDownValue = value;
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _formKey.currentState!.reset();
                            });
                          }, child: const Text('Temizle')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('İptal')),
                      TextButton(
                        onPressed: () {}, child: const Text('Onayla'))
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  List<DropdownMenuItem<String>> dropDownMenuItems() {
    List<DropdownMenuItem<String>> dropDownMenuItemList =
        ConstantCategories.constantTransactionCategoryList
            .map((e) => DropdownMenuItem(value: e.categoryName, child: Text(e.categoryName)))
            .toList();
    return dropDownMenuItemList;
  }

  Future<void> datePickerMethot(
      BuildContext context, currentDate, firstDate) async {
    DateTime? dateChoice = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: currentDate,
    );
    if (dateChoice == null) return;
    setState(() {
      date = dateChoice;
    });
  }

  Text textPicker(date) {
    return date == null
        ? const Text('Tarih')
        : Text(formatDate(date, [dd, '.', mm, '.', yyyy]));
  }
}
