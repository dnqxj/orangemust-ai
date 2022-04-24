import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/global/global_theme.dart';
import 'package:flutter_app/provider/app_provider.dart';
import 'package:flutter_app/view/graphical/graphical_distinguish_view.dart';
import 'package:flutter_app/view/graphical/graphical_index_view.dart';
import 'package:flutter_app/view/home/home_view.dart';
import 'package:flutter_app/view/mine/mine_index_view.dart';
import 'package:flutter_app/view/ocr/ocr_index_view.dart';
import 'package:flutter_app/view/translate/translate_index_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  int _lastTime = 0;
  PageController _pageController;
  int _currentIndex = 0;

  // init data
  List<Widget> _widgetOptions = List();

  @override
  void initState() {
    super.initState();
    _widgetOptions
      ..add(HomeView())
      ..add(GraphicalIndexView())
      ..add(TranslateIndexView())
      ..add(OcrIndexView())
      ..add(MineIndexView());
    _pageController = PageController(initialPage: this._currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = themes[Provider.of<AppProvider>(context).themeColor];
    return WillPopScope(
        child: Scaffold(
          body: PageView(
            children: _widgetOptions,
            onPageChanged: onPageChanged,
            controller: _pageController,
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'home',
            backgroundColor: themeColor,
            onPressed: () {
              onTap(4);
            },
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: themeColor,
            shape: CircularNotchedRectangle(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        onTap(0);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.home, color: getColor(0)),
                          Text("首页", style: TextStyle(color: getColor(0)))
                        ],
                      )),
                  GestureDetector(
                      onTap: () {
                        onTap(1);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.photo, color: getColor(1)),
                          Text("图形", style: TextStyle(color: getColor(1)))
                        ],
                      )),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.transparent,
                      ),
                      Text("我的", style: TextStyle(color: Color(0xFFEEEEEE)))
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        onTap(2);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.brightness_auto, color: getColor(2)),
                          Text("翻译", style: TextStyle(color: getColor(2)))
                        ],
                      )),
                  GestureDetector(
                      onTap: () {
                        onTap(3);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.monochrome_photos, color: getColor(3)),
                          Text("OCR", style: TextStyle(color: getColor(3)))
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          int newTime = DateTime.now().millisecondsSinceEpoch;
          int result = newTime - _lastTime;
          _lastTime = newTime;
          if (result > 2000) {
            Fluttertoast.showToast(
              msg: "This is Center Short Toast",
            );
          } else {
            SystemNavigator.pop();
          }
          return null;
        });
  }

  void onPageChanged(int value) {
    setState(() {
      this._currentIndex = value;
    });
  }

  Color getColor(int value) {
    return this._currentIndex == value
        ? Theme.of(context).cardColor
        : Color(0XFFBBBBBB);
  }

  void onTap(int value) {
    // _pageController.animateToPage(value, duration: const Duration(milliseconds: 100), curve: Curves.ease);
    _pageController.jumpToPage(value);
  }
}
