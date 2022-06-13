import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';
import '../screens/tabs_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildListTile(
      BuildContext context, String title, IconData icon, String pageId) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(pageId);
      },
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Column(
        children: [
          DrawerHeader(
            child: null,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildListTile(
            context,
            'Meals',
            Icons.restaurant,
            TabsScreen.pageId,
          ),
          _buildListTile(
            context,
            'Filters',
            Icons.filter,
            FiltersScreen.pageId,
          ),
        ],
      )),
    );
  }
}
