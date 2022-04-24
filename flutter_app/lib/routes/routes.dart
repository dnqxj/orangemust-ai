import 'package:flutter/material.dart';
import 'package:flutter_app/view/album/album_add_view.dart';
import 'package:flutter_app/view/album/album_list_view.dart';
import 'package:flutter_app/view/graphical/graphical_distinguish_result_view.dart';
import 'package:flutter_app/view/home/home_view.dart';
import 'package:flutter_app/view/menu_view.dart';
import 'package:flutter_app/view/test.dart';
import 'package:flutter_app/view/theme/settings_theme.dart';
import 'package:flutter_app/view/user/login_view.dart';
import 'package:flutter_app/view/user/register_view.dart';

Map<String, WidgetBuilder> routes = {
  "/": (BuildContext context) => MenuView(),
  "menu": (BuildContext context) => MenuView(),
  "login": (BuildContext context) => LoginView(),
  "register": (BuildContext context) => RegisterView(),
  "home": (BuildContext context) => HomeView(),
  "theme": (BuildContext context) => SettingsTheme(),
  "album_list": (BuildContext context) => AlbumListView(),
  "album_add": (BuildContext context) => AlbumAddView(),
  "test": (BuildContext context) => TextDemo(),
  "graphical_distinguish_result": (BuildContext context) =>
      GraphicalDistinguishResultView(),
};
