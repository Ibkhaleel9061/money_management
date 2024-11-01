import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/home/screen_home.dart';
import 'package:money_management/model/category/categoryModel.dart';
import 'package:money_management/model/transaction/transction_model.dart';
import 'package:money_management/transaction/transaction_form.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // data base adapter register  in hive
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(transactionModeAdapter().typeId)) {
    Hive.registerAdapter(transactionModeAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        useMaterial3: true,

        // elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green)),

        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green
            //brightness: Brightness.dark,
            ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20, // add font size
            fontWeight: FontWeight.bold, // add font weight
            fontFamily:
                'Pacifico-Regular', // add font family (make sure to import the font package)
          ),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.green, // Optional: Set FAB color
        ),
      ),
      home: ScreenHome(),
      routes: {transaction_form.routename: (ctx) => transaction_form()},
    );
  }
}
