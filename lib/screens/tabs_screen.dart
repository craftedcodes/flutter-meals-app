import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
  // Dass der Index in _selectPage manuell geändert wird, ist der Grund, weshalb man ein Stateful Widget für eine TabBar im Footer braucht.

  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget.favoriteMeals),
        'title': 'Your Favorites',
      },
    ];
    super.initState();
  }

  Widget build(BuildContext context) {
    // Tabs im Header (kann eigentlich auch in einem stateless Widget verwendet werden):
    //  return DefaultTabController(
    //    length: 2,
    // initialIndex: 0,
    //    child: Scaffold(
    //      appBar: AppBar(
    //        title: Text('Meals'),
    //        bottom: TabBar(
    //          tabs: <Widget>[
    //            Tab(
    //              icon: Icon(Icons.category),
    //              text: 'Categories',
    //            ),
    //            Tab(
    //              icon: Icon(Icons.star),
    //              text: 'Favorites',
    //            ),
    //          ],
    //        ),
    //      ),
    //      body: TabBarView(
    //        children: <Widget>[
    //          CategoriesScreen(),
    //          FavoritesScreen(),
    //        ],
    //      ),
    //    ),
    //  );

    // Tabs im Footer:
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex:
            _selectedPageIndex, // hiermit wird dafür gesorgt, dass das aktuell aktivierte Item die selectedItemColor hat. Das ist nicht per default der Fall.
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
