import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../models/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const pageId = 'category-meals-screen';

  final List<Meal> availableMeals;
  const CategoryMealsScreen({Key? key, required this.availableMeals})
      : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final id = routeArgs['id'];
    final title = routeArgs['title'];

    final categoryMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(id);
    }).toList();
    return Scaffold(
        appBar: AppBar(title: Text(title!)),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              complexity: categoryMeals[index].complexity,
              affordability: categoryMeals[index].affordability,
            );
          },
          itemCount: categoryMeals.length,
        ));
  }
}
