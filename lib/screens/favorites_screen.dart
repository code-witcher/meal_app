import 'package:flutter/material.dart';
import 'package:meal_app/models/meals.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen(this._favoriteMeals, {Key? key}) : super(key: key);

  final List<Meal> _favoriteMeals;

  @override
  Widget build(BuildContext context) {
    return _favoriteMeals.isEmpty
        ? Center(
          
            child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                'You don\'t have favorites yet - try adding some!',
                style: Theme.of(context).textTheme.bodyLarge,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return MealWidget(
                meal: _favoriteMeals[index],
                id: _favoriteMeals[index].id,
                title: _favoriteMeals[index].title,
                duration: _favoriteMeals[index].duration,
                complexity: _favoriteMeals[index].complexity,
                affordability: _favoriteMeals[index].affordability,
              );
            },
            itemCount: _favoriteMeals.length,
          );
  }
}
