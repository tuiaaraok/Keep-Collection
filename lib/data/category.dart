import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  final Uint8List imageCategory;
  @HiveField(1)
  final String nameCategory;
  Category({required this.imageCategory, required this.nameCategory});
}
