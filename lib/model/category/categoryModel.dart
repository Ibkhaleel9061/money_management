import 'package:hive/hive.dart';

part 'categoryModel.g.dart';

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String Id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final CategoryType type;

  CategoryModel({required this.Id, required this.name, required this.type});
  // consater
}
