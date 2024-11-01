import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:money_management/model/category/categoryModel.dart';
part 'transction_model.g.dart';

@HiveType(typeId: 3)
class transactionMode {
  @HiveField(0)
  final String purpos;
  @HiveField(1)
  final double amout;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModel category;

  @HiveField(5)
  String? id;

  transactionMode(
      {required this.purpos,
      required this.amout,
      required this.date,
      required this.type,
      required this.category}) {
    //final id = DateTime.now().millisecondsSinceEpoch.toString();

    final String uniqueKey = Uuid().v4();
    id = uniqueKey;
  }
}

//