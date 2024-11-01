import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/model/category/categoryModel.dart';

ValueNotifier<CategoryType> SelectCategoryNotifier =
    ValueNotifier(CategoryType.income); //radio button selete varibale

// ignore: non_constant_identifier_names
Future<Void> Showcategoryaddpopu(BuildContext context) async {
  final _nameconturl = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('add category'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameconturl,
              decoration: const InputDecoration(
                  hintText: 'Category', border: OutlineInputBorder()),
            ),
          ),

          Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Row(
                children: [
                  Radiobutton(title: 'Income', type: CategoryType.income),
                  Radiobutton(title: 'expense', type: CategoryType.expense)
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final _name = _nameconturl.text;
                    if (_name.isEmpty) {
                      return;
                    }
                    final _type = SelectCategoryNotifier.value;
                    final _category = CategoryModel(
                        Id: DateTime.now().microsecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type);
                    CategoryDB.instance.insertCategory(_category);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Add'))),

          // Radio(value: value, groupValue: groupValue, onChanged: onChanged)
        ],
      );
    },
  );
  return Future.value();
}

// radiobutton classs
class Radiobutton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const Radiobutton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: SelectCategoryNotifier,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                value: type,
                groupValue: SelectCategoryNotifier.value,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  SelectCategoryNotifier.value = value;
                  SelectCategoryNotifier.notifyListeners();
                },
              );
            }),
        Text(title),
      ],
    );
  }
}
