import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String pageId = 'filters-screen';

  final Function saveFilters; //setFilters()
  final Map<String, bool> currentFilters;
  const FiltersScreen(
      {Key? key, required this.currentFilters, required this.saveFilters})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  Widget _buildSwitchListTiles(
      String title, String description, bool currentValue, Function onChanged) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: (value) => onChanged(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('your filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTiles('Gluten-free',
                    'Only includes gluten-free meals', _glutenFree, (value) {
                  setState(() {
                    _glutenFree = value;
                  });
                }),
                _buildSwitchListTiles(
                    'Vegan', 'Only includes vegan meals', _vegan, (value) {
                  setState(() {
                    _vegan = value;
                  });
                }),
                _buildSwitchListTiles(
                    'Vegetarian', 'Only includes vegetarian meals', _vegetarian,
                    (value) {
                  setState(() {
                    _vegetarian = value;
                  });
                }),
                _buildSwitchListTiles('Lactose-free',
                    'Only includes lactose-free meals', _lactoseFree, (value) {
                  setState(() {
                    _lactoseFree = value;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
