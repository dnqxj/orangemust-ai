import 'package:flutter/material.dart';
import 'package:flutter_app/base/view.dart';

class OcrIndexView extends StatefulWidget {
  const OcrIndexView({Key key}) : super(key: key);

  @override
  State<OcrIndexView> createState() => _OcrIndexViewState();
}

class _OcrIndexViewState extends State<OcrIndexView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("OCR"),
    );
  }
}
