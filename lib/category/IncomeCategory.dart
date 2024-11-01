import 'package:flutter/material.dart';

import '../db/category/category_db.dart';
import '../model/category/categoryModel.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomecategoryList,
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
