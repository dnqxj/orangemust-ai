import 'package:flutter/material.dart';
import 'package:flutter_app/global/global_theme.dart';
import 'package:flutter_app/provider/app_provider.dart';
import 'package:flutter_app/view/home/home_view.dart';
import 'package:provider/provider.dart';
import 'album/album_list_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  // init data
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    AlbumListView(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: '相册'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: themes[Provider.of<AppProvider>(context).themeColor],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
