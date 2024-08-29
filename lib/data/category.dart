import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  final Uint8List image_category;
  @HiveField(1)
  final String name_category;
  Category({required this.image_category, required this.name_category});
}
