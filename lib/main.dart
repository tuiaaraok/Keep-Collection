import 'package:flutter/material.dart';
import 'package:geek_collectors/add_category_screen.dart';
import 'package:geek_collectors/menu_page.dart';
import 'package:geek_collectors/redact_collaction.dart';
import 'package:geek_collectors/add_collection_page.dart';
import 'package:geek_collectors/boxes.dart';
import 'package:geek_collectors/collection_screen.dart';
import 'package:geek_collectors/create_first_category.dart';
import 'package:geek_collectors/data/category.dart';
import 'package:geek_collectors/data/collection.dart';
import 'package:geek_collectors/home_screen.dart';
import 'package:geek_collectors/navigation/navigation.dart';
import 'package:geek_collectors/onboarding_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(CollectionAdapter());

  await Hive.openBox<Category>(HiveBoxes.category);
  await Hive.openBox<Collection>(HiveBoxes.collection);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: NavigationApp.generateRoute,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.black,
                appBarTheme: AppBarTheme(backgroundColor: Colors.transparent)),
            home: Hive.box<Category>(HiveBoxes.category).isEmpty
                ? OnboardingScreen()
                : MenuPage()));
  }
}
// CollectionScreen(
//               name_category: "Old Money",
//             )