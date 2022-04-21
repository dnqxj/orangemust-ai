import 'package:flutter/material.dart';
import 'package:flutter_app/base/view.dart';

class TranslateIndexView extends StatefulWidget {
  const TranslateIndexView({Key key}) : super(key: key);

  @override
  State<TranslateIndexView> createState() => _TranslateIndexViewState();
}

class _TranslateIndexViewState extends State<TranslateIndexView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("翻译"),
    );
  }
}
