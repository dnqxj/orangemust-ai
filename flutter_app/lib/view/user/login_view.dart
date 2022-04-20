import 'dart:async';
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/view.dart';
import 'package:flutter_app/global/Global.dart';
import 'package:flutter_app/provider/app_provider.dart';
import 'package:flutter_app/utils/alert_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/eventbus/event_bus.dart';
import 'package:weui/toast/index.dart';
import 'package:flutter_app/apis/user/index.dart' as UserApi;

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // init data
  TextEditingController _user;
  TextEditingController _pass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = new TextEditingController();
    _pass = new TextEditingController();
    // bus.on("fail", (arg) {  // 订阅消息，来自viewmodel层
    //   if (arg["view"] == "login") {
    //     WeToast.fail(context)(message: arg["message"]);
    //   }
    // });
    // bus.on("moration_day", (arg) {  // 订阅消息，来自viewmodel层
    //   if (arg["view"] == "login") {
    //     WeDialog.alert(context)(arg["message"]);
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // 关闭两个控制器，节省资源
    _user.dispose();
    _pass.dispose();
    bus.off("fail"); // 关闭消息订阅
    bus.off("moration_day");
  }

  // view

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("登录"),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Image.asset(
              "images/main_show.jpg",
              width: double.infinity,
              height: 130,
              // fit: BoxFit.fill,
            ),
            SizedBox(height: 16,),
            // WeForm(
            //     children: [
            //       WeInput(
            //         autofocus: true,  // 自动获取光标
            //         label: "账号",
            //         hintText: "请输入账号",
            //         clearable: true,
            //         textInputAction: TextInputAction.next, // 输入法右侧按钮
            //       ),
            //       WeInput(
            //         label: "密码",
            //         hintText: "请输入密码",
            //         clearable: true,
            //         obscureText: true,
            //         textInputAction: TextInputAction.send,
            //         // footer: Icon(Icons.add),
            //       ),
            //     ]
            // ),
            TextField(
              decoration: InputDecoration(
                labelText: "账号",
                hintText: "请输入账号",
                prefix: Icon(Icons.person),
              ),
              controller: _user,  // 有控制器才能获取到值
              autofocus: true,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "请输入密码",
                prefix: Icon(Icons.lock)
              ),
              controller: _pass,
              obscureText: true,
              textInputAction: TextInputAction.send,
              onSubmitted: submit,
            ),
            SizedBox(height: 16,),
            GestureDetector(
              child: Container(
                width: double.infinity,
                child: Text(
                  "找回密码",
                  style: TextStyle(color: Colors.blue),
                  textAlign: TextAlign.right,
                ),
              ),
              onTap: () {
                print("找回密码");
              },
            ),
            SizedBox(height: 16,),

            Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              child: RaisedButton(
                onPressed: _login,
                child: const Text('登录'),
              ),
            ),
            SizedBox(height: 8,),
            Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              child: RaisedButton(
                onPressed: _register,
                child: const Text('注册'),
              ),
            ),
          ],
        ),
      )
    );
  }

  void submit(String) {
    _login();
  }

  // 第一种传入上下文对象的方式
  void _login() async {
    if (_user.text == null || _user.text.isEmpty) {
      WeToast.fail(context)(message: "账号不能为空~");
      return;
    }
    if (_pass.text == null || _pass.text.isEmpty) {
      WeToast.fail(context)(message: "密码不能为空~");
      return;
    }

    HashMap<String, Object> params = new HashMap();
    params['username'] = _user.text;
    params['password'] = _pass.text;
    print(params);
    Response result = null;
    try {
      result = await UserApi.login(params);
    } catch (e) {
      print(e.toString());
    }
    print(result);
    if(result.data['success']) {
      String token = result.data["data"]["token"];
      Map userInfo = result.data["data"]["user"];
      // 全局运行中状态类
      Global.getInstance().dio.options.headers["Authorization"] = token;
      // 放到provider中，相当于vuex
      context.read<AppProvider>().setIsLogin(true);
      context.read<AppProvider>().setToken(token);
      context.read<AppProvider>().setUserInfo(userInfo);
      // 1s后跳转菜单界面
      new Timer(Duration(seconds: 1), () {
        //  注册成功跳转登录页面
        Navigator.of(context).popAndPushNamed("menu");
      });
    } else {
      await showAlertDialog(context, "错误", result.data['message']);
    }
  }

  void _register() {
    Navigator.of(context).pushNamed("register");
  }
}














