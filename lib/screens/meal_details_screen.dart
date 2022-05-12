import 'package:flutter/material.dart';
import '../widgets/meal_details_widget.dart';
import '../models/dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen(this.toggleFavorites, this._isFavorite, {Key? key})
      : super(key: key);

  static const String mealDetailsScreen = '/meal-details';
  final Function toggleFavorites;
  final Function _isFavorite;

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context)?.settings.arguments as String;

    final selectedMeal = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == mealId;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: Center(
        child: MealDetailsWidget(
          selectedMeal: selectedMeal,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          _isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorites(mealId),
      ),
    );
  }
}
