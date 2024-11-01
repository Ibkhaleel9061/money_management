//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:money_management/model/transaction/transction_model.dart';

const TRANSACTIOM_DB_NAME = 'transaction-DB';

abstract class TransactionDBfunction {
  Future<List<transactionMode>> getallTranscation();
  Future<void> addTransaction(transactionMode obj);
  Future<void> deleteTransactiony(String id);
}

class TransactionDB implements TransactionDBfunction {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<transactionMode>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(transactionMode obj) async {
    final _DB = await Hive.openBox<transactionMode>(TRANSACTIOM_DB_NAME);
    //Hive
    await _DB.put(obj.id, obj);
    // getallTranscation();
  }

  @override
  Future<List<transactionMode>> getallTranscation() async {
    final _DB = await Hive.openBox<transactionMode>(TRANSACTIOM_DB_NAME);
    return _DB.values.toList();
  }

  Future<void> UIrefersh() async {
    final _list = await getallTranscation();
    _list.sort((fiste, second) => second.date.compareTo(fiste.date));

    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteTransactiony(String id) async {
    final _DB = await Hive.openBox<transactionMode>(TRANSACTIOM_DB_NAME);
    await _DB.delete(id);
    UIrefersh();
  }
}
