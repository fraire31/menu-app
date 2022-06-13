import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const pageId = 'meal-details-screen';
  final Function toggleFavorite;
  final Function isFavorite;

  const MealDetailsScreen(
      {Key? key, required this.toggleFavorite, required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((meal) => meal.id == mealId);

    Widget _buildListView(String type) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.only(
              left: 0,
            ),
            title: Text(
              type == 'ingredients'
                  ? selectedMeal.ingredients[index]
                  : selectedMeal.steps[index],
            ),
            leading: type == 'steps'
                ? CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          '# ${index + 1}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            letterSpacing: .25,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
          );
        },
        itemCount: type == 'ingredients'
            ? selectedMeal.ingredients.length
            : selectedMeal.steps.length,
      );
    }

    Widget _buildTitleContainer(String type) {
      return Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Text(
          type,
          style: Theme.of(context).textTheme.caption,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            _buildTitleContainer('Ingredients'),
            Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * .07),
              child: _buildListView('ingredients'),
            ),
            _buildTitleContainer('Steps'),
            Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: _buildListView('steps'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
          color: Colors.white,
        ),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}
