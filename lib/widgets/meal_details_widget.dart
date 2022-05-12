import 'package:flutter/material.dart';
import 'package:meal_app/models/meals.dart';

import '../models/dummy_data.dart';

class MealDetailsWidget extends StatelessWidget {
  const MealDetailsWidget({
    Key? key,
    required this.selectedMeal,
  }) : super(key: key);

  final Meal selectedMeal;

  Widget sectionBuilder(String text, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget contentBuilder(
      {required Widget child, required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 200,
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          sectionBuilder('Ingrediants.', context),
          contentBuilder(
            context: context,
            child: ListView.builder(
              itemBuilder: (context, index) => Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    '${index + 1}-  ${selectedMeal.ingredients[index]}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              itemCount: selectedMeal.ingredients.length,
            ),
          ),
          sectionBuilder('Steps.', context),
          contentBuilder(
            context: context,
            child: ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${index + 1}'),
                    ),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  const Divider(
                    color: Colors.grey,
                    endIndent: 20,
                    indent: 20,
                  ),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ),
          ),
        ],
      ),
    );
  }
}
