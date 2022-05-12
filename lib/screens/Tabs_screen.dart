import 'package:flutter/material.dart';
import 'package:meal_app/models/meals.dart';
import 'package:meal_app/widgets/Drawer_widget.dart';
import '../screens/categories_page.dart';
import '../screens/favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen(this._favoriteMeals, {Key? key}) : super(key: key);

  final List<Meal> _favoriteMeals;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> pages;

  int _selectedPage = 0;

  @override
  void initState() {
    pages = [
      {'page': const CategoriesPage(), 'title': 'Meals Categories'},
      {'page': FavoritesScreen(widget._favoriteMeals), 'title': 'Favorite Meals'},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pages[_selectedPage]['title'].toString()),
        ),
        drawer: DrawerWidget(),
        body: pages[_selectedPage]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.category),
              label: 'Categories',
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.star),
              label: 'Favorites',
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
          onTap: _selectPage,
          currentIndex: _selectedPage,
        ),
      ),
    );
  }
}
