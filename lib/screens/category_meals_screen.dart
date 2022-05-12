import 'package:flutter/material.dart';

import '../models/meals.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const catMealsPage = '/category-meals';

  List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals, {Key? key}) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  late List<Meal> displayedMeals;

  String? routeTitle;

  var removed = false;

  @override
  void didChangeDependencies() {
    if (!removed) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;

      final String? routeId = routeArgs['id'];
      routeTitle = routeArgs['title'];

      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(routeId);
      }).toList();
      removed = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealWidget(
            // removeMeal: _removeMeal,
            meal: displayedMeals[index],
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
