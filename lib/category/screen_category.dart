import 'package:flutter/material.dart';
import 'package:money_management/category/ExpenseCategory.dart';
import 'package:money_management/category/IncomeCategory.dart';
import 'package:money_management/db/category/category_db.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController; // Initialize TabController

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);

    //getcategory call heyar
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'INCOME',
              ),
              Tab(
                text: 'EXPENS',
              )
            ]),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: [IncomeCategory(), ExpenseCategory()],
        ))
      ],
    );
  }
}
