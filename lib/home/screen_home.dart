import 'package:flutter/material.dart';
import 'package:money_management/category/Category_pop_page.dart';
import 'package:money_management/category/screen_category.dart';
import 'package:money_management/home/botton_navigation.dart';
import 'package:money_management/transaction/screen_transaction.dart';
import 'package:money_management/transaction/transaction_form.dart';

// home screen

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier =
      ValueNotifier(0); //select naviction bottn varibale

  final _pages = const [
    ScreenTranssction(),
    ScreenCategory()
  ]; // Home page view  category & transaction pagss  varibel array list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'money management',
        ),
      ),
      bottomNavigationBar: const MoneyMangementBottonNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (BuildContext context, int updateIndex, _) {
              return _pages[updateIndex];
            }),
      ),

      // forme action button
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedIndexNotifier.value == 0) {
              Navigator.of(context).pushNamed(transaction_form.routename);
            } else {
              Showcategoryaddpopu(context);
            }
          },
          child: Icon(Icons.add)),
    );
  }
}
