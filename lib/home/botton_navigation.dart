import 'package:flutter/material.dart';
import 'package:money_management/home/screen_home.dart';

// transcation & category  navigation botton class
class MoneyMangementBottonNavigation extends StatelessWidget {
  const MoneyMangementBottonNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ScreenHome.selectedIndexNotifier,
        builder: (BuildContext ctx, int updateIndex, Widget? _) {
          return BottomNavigationBar(
              currentIndex: updateIndex,
              onTap: (newIndex) {
                ScreenHome.selectedIndexNotifier.value = newIndex;
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'transcation'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'category')
              ]);
        });
  }
}
