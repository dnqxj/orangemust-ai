import 'package:flutter/material.dart';
import 'package:flutter_app/base/view.dart';

class MineIndexView extends StatefulWidget {
  const MineIndexView({Key key}) : super(key: key);

  @override
  State<MineIndexView> createState() => _MineIndexViewState();
}

class _MineIndexViewState extends State<MineIndexView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("我的"),
    );
  }
}
