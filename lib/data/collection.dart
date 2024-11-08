import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'collection.g.dart';

@HiveType(typeId: 2)
class Collection {
  @HiveField(0)
  final String nameCategory;
  @HiveField(1)
  final Uint8List imageCollection;
  @HiveField(2)
  final String nameCollection;
  @HiveField(3)
  final String yearOfProduction;
  @HiveField(4)
  final String cost;
  @HiveField(5)
  final String description;
  Collection({
    required this.nameCategory,
    required this.imageCollection,
    required this.nameCollection,
    required this.yearOfProduction,
    required this.cost,
    required this.description,
  });
}
