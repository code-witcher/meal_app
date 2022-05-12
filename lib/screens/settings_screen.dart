import 'package:flutter/material.dart';
import 'package:meal_app/models/filters_vars.dart';
import 'package:meal_app/widgets/Drawer_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
    required this.saveFilter,
    required this.selectedFilters,
  }) : super(key: key);

  final Function saveFilter;
  final FiltersVars selectedFilters;

  static const settingsRoute = '/settings-screen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegetarian = false;

  @override
  void initState(){
    super.initState();

    _glutenFree = widget.selectedFilters.gluten;
    _lactoseFree = widget.selectedFilters.lactose;
    _vegan = widget.selectedFilters.vegan;
    _vegetarian = widget.selectedFilters.vegetarian;

  }

  Widget _buildSwitchListTile({
    required bool currentValue,
    required String title,
    required String description,
    required Function(bool) onTap,
  }) {
    return SwitchListTile(
      value: currentValue,
      onChanged: onTap,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              FiltersVars _selectedFilters = FiltersVars(
                gluten: _glutenFree,
                lactose: _lactoseFree,
                vegan: _vegan,
                vegetarian: _vegetarian,
              );

              widget.saveFilter(_selectedFilters);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              'Adjust Your Meal Selection!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                currentValue: _glutenFree,
                title: 'Gluten-Free',
                description: 'Only includ gluten-free Meals!',
                onTap: (newVlaue) {
                  setState(() {
                    _glutenFree = newVlaue;
                  });
                },
              ),
              _buildSwitchListTile(
                currentValue: _lactoseFree,
                title: 'Lactose-Free',
                description: 'Only includ lactose-free Meals!',
                onTap: (newVlaue) {
                  setState(() {
                    _lactoseFree = newVlaue;
                  });
                },
              ),
              _buildSwitchListTile(
                currentValue: _vegan,
                title: 'Vegan',
                description: 'Only includ vegan Meals!',
                onTap: (newVlaue) {
                  setState(() {
                    _vegan = newVlaue;
                  });
                },
              ),
              _buildSwitchListTile(
                currentValue: _vegetarian,
                title: 'Vegetarian',
                description: 'Only includ vegetarian Meals!',
                onTap: (newVlaue) {
                  setState(() {
                    _vegetarian = newVlaue;
                  });
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
