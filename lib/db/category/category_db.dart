//import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/category/categoryModel.dart';

const CATEGORY_DB_NAME = 'category database';

abstract class CategoryDBfunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deletecategory(String categoryID);
}

class CategoryDB implements CategoryDBfunctions {
  /*_internal() wich is called exactly once, and since it is private it can only be called in 
  this Class and we also prevent it from being instantiated outside of here. This constructor
   can be used to initialize logic.*/
  CategoryDB._internal();

  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomecategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expensecategoryList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _CATEGORY_DB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _CATEGORY_DB.put(value.Id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _CATEGORY_DB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _CATEGORY_DB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allcategory = await getCategories();
    incomecategoryList.value.clear();
    expensecategoryList.value.clear();

    Future.forEach(_allcategory, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomecategoryList.value.add(category);
      } else {
        expensecategoryList.value.add(category);
      }
      /*refreshUI();*/
    });
    incomecategoryList.notifyListeners();
    expensecategoryList.notifyListeners();
  }

  @override
  Future<void> deletecategory(String categoryID) async {
    final _CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _CategoryDB.delete(categoryID);
    refreshUI();
  }
}
