import 'package:flutter/material.dart';

AppBar getAppBar(String title) {
  return AppBar(
    title: Text(title),
    elevation: 10,
    centerTitle: true,
  );
}

AppBar getAppBarActions(String title, List<Widget> actions) {
  return AppBar(
    title: Text(title),
    elevation: 10,
    centerTitle: true,
    actions: actions,
  );
}
