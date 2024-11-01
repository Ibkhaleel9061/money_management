 
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/model/category/categoryModel.dart';
import 'package:money_management/model/transaction/transction_model.dart';

class ScreenTranssction extends StatelessWidget {
  const ScreenTranssction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.UIrefersh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<transactionMode> newlist, Widget? _) {
        return ListView.separated(
            padding: EdgeInsets.all(6), //////////////
            itemBuilder: (ctx, index) {
              final _khal = newlist[index];
              return Slidable(
                key: Key(_khal.id!),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        TransactionDB.instance.deleteTransactiony(_khal.id!);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 50,
                      child: Text(
                        parseDate(_khal.date),
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 8, fontWeight: FontWeight.w900),
                      ),
                      backgroundColor: _khal.type == CategoryType.income
                          ? Colors.green
                          : Colors.red,
                    ),
                    title: Text('RS:${_khal.amout}'),
                    subtitle: Text(
                      ' Purpose :${_khal.purpos},\nCategory:${_khal.category.name},',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    /* contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: -30),*/
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return SizedBox(height: 10);
            },
            itemCount: newlist.length);
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat('dd MMM yyyy').format(date);
    final _splitDate = _date.split(' '); // Splitting by space
    return '${_splitDate[0]}\n${_splitDate[1]} ${_splitDate[2]}';
  }
}
