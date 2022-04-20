import 'package:flutter/material.dart';
import 'package:flutter_app/base/view.dart';
import 'package:flutter_app/global/global_theme.dart';
import 'package:flutter_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:weui/icon/index.dart';

class SettingsTheme extends StatefulWidget {
  const SettingsTheme({Key key}) : super(key: key);

  @override
  _SettingsThemeState createState() => _SettingsThemeState();
}

class _SettingsThemeState extends State<SettingsTheme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("设置主题"),
      body: ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: themes.length,
        shrinkWrap: true,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: themes[index],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Provider.of<AppProvider>(context).themeColor == index ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                WeIcons.hook,
                color: Colors.white,
              ),
              SizedBox(width: 16),
            ],
          ) : Row(),
        ),
        onTap: () {
          context.read<AppProvider>().setThemeColor(index);
        },
      ),
    );
  }
}
