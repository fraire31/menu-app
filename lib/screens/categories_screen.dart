import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  static const String pageId = 'categories-screen';

  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: dummyCategories
          .map((data) => CategoryItem(
                id: data.id,
                title: data.title,
                color: data.color,
              ))
          .toList(),
    );
  }
}
