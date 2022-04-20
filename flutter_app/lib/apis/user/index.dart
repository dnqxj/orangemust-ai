import 'package:flutter_app/global/Global.dart';

var dio = Global.getInstance().dio;

// 用户登录
Future login(data)async {
  return await Global.getInstance().dio.post("/user/login", data: data);
}

// 用户注册
Future register(data)async {
  return await Global.getInstance().dio.post("/user/register", data: data);
}

// 获取用户信息
Future getUserInfo()async {
  return await dio.get("/user/getUserInfo");
}