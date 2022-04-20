import 'package:flutter/material.dart';
import 'package:flutter_app/global/global_theme.dart';
import 'package:flutter_app/provider/app_provider.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

int _color;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(MyApp());
  SharedPreferences sp = await SharedPreferences.getInstance();
  _color = await sp.getInt("color") ?? 0;
  AppProvider appProvider = AppProvider();
  appProvider.setThemeColor(_color);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => appProvider),
        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Love App',
      theme: ThemeData.light().copyWith(
        primaryColor: themes[Provider.of<AppProvider>(context).themeColor],
        buttonTheme: ButtonThemeData(
          buttonColor: themes[Provider.of<AppProvider>(context).themeColor],
          textTheme: ButtonTextTheme.primary,
        )
      ),
      routes: routes,
      initialRoute: "login",
    );
  }
}
