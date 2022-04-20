import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

Future showMonthList(List list) async {
  return await showDialog(
    context: navigatorKey.currentContext,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text("选择统计月份"),
        children: list.map((e) {
          return SimpleDialogOption(
            child: Text(e.toString() + "月"),
            onPressed: () {
              Navigator.pop(context, e);
            },
          );
        }).toList(),
      );
    },
    barrierDismissible: false,
  );
}

Future showObjectAlertDialog(List list, String title, String content) async {
  return await showDialog(
    context: navigatorKey.currentContext,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(title),
        children: list.map((e) {
          return SimpleDialogOption(
            child: Text(e[content]),
            onPressed: () {
              Navigator.pop(context, e);
            },
          );
        }).toList(),
      );
    },
    barrierDismissible: false,
  );
}

Future showListAlertDialog(List list, String title) async {
  return await showDialog(
    context: navigatorKey.currentContext,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(title),
        children: list.map((e) {
          return SimpleDialogOption(
            child: Text(e.toString()),
            onPressed: () {
              Navigator.pop(context, e);
            },
          );
        }).toList(),
      );
    },
    barrierDismissible: false,
  );
}

// 展示普通的弹窗
Future<void> showAlertDialog(BuildContext context, String title, String description) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(description),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('确认'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}