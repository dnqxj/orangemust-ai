import 'package:flutter/material.dart';
import 'package:flutter_app/global/global_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  int _themeColor = 0;
  String _token = "";
  bool _isLogin = false;
  Map _userInfo = {};

  int get themeColor => _themeColor;

  void setThemeColor(int value)async {
    if (value > themes.length - 1) return;
    _themeColor = value;
    // 持久化保持
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("themeColor", _themeColor);
    notifyListeners();
  }

  String get token => _token;

  void setToken(String value)async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", value);
    _token = value;
    notifyListeners();
  }

  bool get isLogin => _isLogin;

  void setIsLogin(bool value)async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("isLogin", value);
    _isLogin = value;
    notifyListeners();
  }

  get userInfo => _userInfo;

  // 设置用户info
  void setUserInfo(Map userInfo)async {
    // 持久化保持
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("userInfo", userInfo.toString());
    _userInfo = userInfo;
    notifyListeners();
  }

  // 退出登录
  void logout()async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", "");
    sp.setBool("isLogin", false);
    sp.setString("userInfo", "");
    _token = "";
    _isLogin = false;
    // _userInfo = {};
    notifyListeners();
  }
}