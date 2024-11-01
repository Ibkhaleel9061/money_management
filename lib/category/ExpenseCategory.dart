import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/model/category/categoryModel.dart';

// expention  category page view list

class ExpenseCategory extends StatelessWidget {
  const ExpenseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expensecategoryList,
      builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
        return ListView.separated(
            itemBuilder: (ctx, index) {
              final khal = newlist[index];
              return Card(
                  child: ListTile(
                title: Text(khal.name),
                trailing: IconButton(
                    onPressed: () {
                      CategoryDB.instance.deletecategory(khal.Id);
                    },
                    icon: Icon(Icons.delete)),
              ));
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newlist.length);
      },
    );
  }
}
