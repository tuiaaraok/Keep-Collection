import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'collection.g.dart';

@HiveType(typeId: 2)
class Collection {
  @HiveField(0)
  final String name_category;
  @HiveField(1)
  final Uint8List image_collection;
  @HiveField(2)
  final String name_collection;
  @HiveField(3)
  final String year_of_production;
  @HiveField(4)
  final String cost;
  @HiveField(5)
  final String description;
  Collection({
    required this.name_category,
    required this.image_collection,
    required this.name_collection,
    required this.year_of_production,
    required this.cost,
    required this.description,
  });
}
