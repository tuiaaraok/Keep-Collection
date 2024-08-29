import 'package:flutter/material.dart';
import 'package:geek_collectors/add_category_screen.dart';
import 'package:geek_collectors/add_collection_page.dart';
import 'package:geek_collectors/collection_screen.dart';
import 'package:geek_collectors/create_first_category.dart';
import 'package:geek_collectors/data/category.dart';
import 'package:geek_collectors/home_screen.dart';
import 'package:geek_collectors/menu_page.dart';
import 'package:geek_collectors/onboarding_screen.dart';
import 'package:geek_collectors/redact_collaction.dart';

const String onboarding_screen = "/onboarding-screen";
const String home_screen = "/home-screen";
const String add_category_screen = "/add-category-screen";
const String add_collection_page = "/add-collection-page";
const String collection_screen = "/collection-screen";
const String redact_collection = "/redact-collection";
const String create_first_category = "/create-first-category";
const String menu_page = "/menu-page";

class NavigationApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding_screen:
        return MaterialPageRoute(
          builder: (_) {
            return OnboardingScreen();
          },
          settings: settings,
        );
      case add_category_screen:
        var args =
            settings.arguments == null ? false : settings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) {
            return AddCategoryScreen(
              isFistCategory: args,
            );
          },
          settings: settings,
        );
      case create_first_category:
        return MaterialPageRoute(
          builder: (_) {
            return CreateFirstCategory();
          },
          settings: settings,
        );
      case menu_page:
        return MaterialPageRoute(
          builder: (_) {
            return MenuPage();
          },
          settings: settings,
        );
      case add_collection_page:
        var args =
            settings.arguments == null ? '' : settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) {
            return AddCollectionPage(
              category: args,
            );
          },
          settings: settings,
        );
      case home_screen:
        var args = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) {
            return HomeScreen(
              isCreateCollection: args,
            );
          },
          settings: settings,
        );
      case collection_screen:
        var args = settings.arguments as Category;
        return MaterialPageRoute(
          builder: (_) {
            return CollectionScreen(
              category: args,
            );
          },
          settings: settings,
        );
      case redact_collection:
        var args = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) {
            return RedactCollaction(
              index: args,
            );
          },
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return OnboardingScreen();
          },
          settings: settings,
        );
    }
  }
}
