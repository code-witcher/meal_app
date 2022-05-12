import 'package:flutter/material.dart';
import 'package:meal_app/models/filters_vars.dart';

import './models/dummy_data.dart';
import './screens/Tabs_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/settings_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_page.dart';
import './models/meals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  FiltersVars _filter = FiltersVars(
    gluten: false,
    lactose: false,
    vegan: false,
    vegetarian: false,
  );

  void _saveFilters(FiltersVars filters) {
    setState(() {
      _filter = filters;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filter.gluten && !meal.isGlutenFree) {
          return false;
        }
        if (_filter.lactose && !meal.isLactoseFree) {
          return false;
        }
        if (_filter.vegan && !meal.isVegan) {
          return false;
        }
        if (_filter.vegetarian && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorites(String mealId) {
    int? exictingIndex = _favoriteMeals.indexWhere((meal) {
      return mealId == meal.id;
    });

    if (exictingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(exictingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) {
          return mealId == meal.id;
        }));
      });
    }
  }

  bool isFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            color: Color.fromRGBO(20, 51, 51, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: TabsScreen(_favoriteMeals),
      initialRoute: '/',
      routes: {
        CategoryMealsScreen.catMealsPage: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailsScreen.mealDetailsScreen: (context) =>
            MealDetailsScreen(toggleFavorites, isFavorite),
        SettingsScreen.settingsRoute: (context) => SettingsScreen(
              saveFilter: _saveFilters,
              selectedFilters: _filter,
            ),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const CategoriesPage());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const CategoriesPage());
      },
    );
  }
}
