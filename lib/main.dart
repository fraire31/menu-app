import 'package:flutter/material.dart';

import './models/meal.dart';
import '../data/dummy_data.dart';
import '../screens/categories_screen.dart';
import '../screens/category_meals_screen.dart';
import '../screens/filters_screen.dart';
import '../screens/meal_details_screen.dart';
import '../screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      print('setting filters in main dart');
      _availableMeals = dummyMeals.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }

        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }

        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }

        if (_filters['vegan']! && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    //click on favorites button that is next to the meal
    //if the meal is already in favorites list, it will be removed
    //if the meal is not in the favorites list, it will be added
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli Meals',
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              caption: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
            ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
        ),
      ),
      initialRoute: TabsScreen.pageId,
      routes: {
        TabsScreen.pageId: (context) =>
            TabsScreen(favoriteMeals: _favoriteMeals),
        CategoriesScreen.pageId: (context) => CategoriesScreen(),
        CategoryMealsScreen.pageId: (context) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailsScreen.pageId: (context) => MealDetailsScreen(
            toggleFavorite: _toggleFavorite, isFavorite: _isMealFavorite),
        FiltersScreen.pageId: (context) =>
            FiltersScreen(currentFilters: _filters, saveFilters: _setFilters),
      },
    );
  }
}
