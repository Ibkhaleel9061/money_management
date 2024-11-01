import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
//import 'package:money_management/home/screen_home.dart';
import 'package:money_management/model/category/categoryModel.dart';
import 'package:money_management/model/transaction/transction_model.dart';

class transaction_form extends StatefulWidget {
  static const routename = 'add TranctionFome';
  const transaction_form({super.key});

  @override
  State<transaction_form> createState() => _transaction_formState();
}

class _transaction_formState extends State<transaction_form> {
  DateTime? _SelecteDate;
  CategoryType? _SelecteCategoryType;
  CategoryModel? _SelecteCategoryModel;

  String? _CategorID;

  final _purpostextEditingController = TextEditingController();
  final _amounttextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction '),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _purpostextEditingController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: 'purpase'),
            ),
            TextFormField(
              controller: _amounttextEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
            TextButton.icon(
                onPressed: () async {
                  final _selecteDatetemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now());
                  if (_selecteDatetemp == null) {
                    return;
                  } else {
                    print(_selecteDatetemp.toString());
                    setState(() {
                      _SelecteDate = _selecteDatetemp;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(_SelecteDate == null
                    ? 'Select Data'
                    : _SelecteDate!.toString())),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: _SelecteCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _SelecteCategoryType = CategoryType.income;
                            _CategorID = null;
                          });
                        }),
                    Text('income')
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CategoryType.expense,
                        groupValue: _SelecteCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _SelecteCategoryType = CategoryType.expense;
                            _CategorID = null;
                          });
                        }),
                    Text('expenss')
                  ],
                ),
              ],
            ),
            DropdownButton<String>(
              hint: const Text('Select Category'),
              value: _CategorID,
              items: (_SelecteCategoryType == CategoryType.expense
                      ? CategoryDB().expensecategoryList
                      : CategoryDB().incomecategoryList)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  value: e.Id,
                  child: Text(e.name),
                  onTap: () {
                    print(e.toString());
                    _SelecteCategoryModel = e;
                  },
                );
              }).toList(),
              onChanged: (SelectedValue) {
                print(SelectedValue);
                setState(() {
                  _CategorID = SelectedValue;
                });
              },
              onTap: () {},
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  width: 100, // Set the width you want
                  height: 30, // Set the height you want
                  child: Container(
                    color: Colors.white, // Example content
                  ),
                ),
                // Add more widgets here
              ],
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    addTranscationform();
                  },
                  child: Text('Submit')),
            )
          ],
        ),
      )),
    );
  }

  Future<void> addTranscationform() async {
    final _purpostext = _purpostextEditingController.text;
    final _amouttext = _amounttextEditingController.text;

    if (_purpostext.isEmpty) {
      return;
    }

    if (_amouttext.isEmpty) {
      return;
    }

    if (_CategorID == null) {
      return;
    }
    if (_SelecteDate == null) {
      return;
    }

    final _purposamount = double.tryParse(_amouttext);
    if (_purposamount == null) {
      return;
    }

    final _model = transactionMode(
      purpos: _purpostext,
      amout: _purposamount,
      date: _SelecteDate!,
      type: _SelecteCategoryType!,
      category: _SelecteCategoryModel!,
    );

    TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.UIrefersh();
  }
}
