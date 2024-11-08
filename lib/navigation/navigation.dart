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

const String onboardingScreen = "/onboarding-screen";
const String homeScreen = "/home-screen";
const String addCategoryScreen = "/add-category-screen";
const String addCollectionPage = "/add-collection-page";
const String collectionScreen = "/collection-screen";
const String redactCollection = "/redact-collection";
const String createFirstCategory = "/create-first-category";
const String menuPage = "/menu-page";

class NavigationApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboardingScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const OnboardingScreen();
          },
          settings: settings,
        );
      case addCategoryScreen:
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
      case createFirstCategory:
        return MaterialPageRoute(
          builder: (_) {
            return const CreateFirstCategory();
          },
          settings: settings,
        );
      case menuPage:
        return MaterialPageRoute(
          builder: (_) {
            return const MenuPage();
          },
          settings: settings,
        );
      case addCollectionPage:
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
      case homeScreen:
        var args = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) {
            return HomeScreen(
              isCreateCollection: args,
            );
          },
          settings: settings,
        );
      case collectionScreen:
        var args = settings.arguments as Category;
        return MaterialPageRoute(
          builder: (_) {
            return CollectionScreen(
              category: args,
            );
          },
          settings: settings,
        );
      case redactCollection:
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
            return const OnboardingScreen();
          },
          settings: settings,
        );
    }
  }
}
