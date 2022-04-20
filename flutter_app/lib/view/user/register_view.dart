import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_app/base/view.dart';
import 'package:flutter_app/eventbus/event_bus.dart';
import 'package:flutter_app/global/global_theme.dart';
import 'package:flutter_app/provider/app_provider.dart';
import 'package:flutter_app/utils/alert_utils.dart';
import 'package:flutter_app/utils/data_utils.dart';
import 'package:provider/provider.dart';
import 'package:weui/cell/index.dart';
import 'package:weui/dialog/index.dart';
import 'package:weui/form/index.dart';
import 'package:weui/input/index.dart';
import 'package:weui/switch/index.dart';
import 'package:weui/toast/index.dart';
import 'package:flutter_app/apis/user/index.dart' as UserApi;


class RegisterView extends StatefulWidget {
  const RegisterView({Key key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _user;
  TextEditingController _pass;
  TextEditingController _confirmPass;
  TextEditingController _name;

  DateTime _dateTime;
  int _gender = 0; // 0=男;1=女
  int _solar = 0; // 0=阳历;1=公历

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = TextEditingController();
    _pass = TextEditingController();
    _confirmPass = TextEditingController();
    _name = TextEditingController();
    bus.on("fail", (arg) {  // 订阅消息，来自viewmodel层
      if (arg["view"] == "register") {
        WeToast.fail(context)(message: arg["message"]);
      }
    });
    bus.on("moration_day", (arg) {  // 订阅消息，来自viewmodel层
      if (arg["view"] == "register") {
        WeDialog.alert(context)(arg["message"]);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _user.dispose();
    _pass.dispose();
    _confirmPass.dispose();
    _name.dispose();
    bus.off("fail");
    bus.off("moration_day");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("注册"),
      body: WeForm(
        children: [
          WeInput(
            label: "登录账号",
            hintText: "请输入登录用户名",
            clearable: true,
            textInputAction: TextInputAction.next,
            onChange: (v) {
              _user.text = v;
            },
          ),
          WeInput(
            label: "登录密码",
            hintText: "请输入登录密码",
            textInputAction: TextInputAction.next,
            clearable: true,
            obscureText: true,
            onChange: (v) {
              _pass.text = v;
            },
          ),
          WeInput(
            label: "确认密码",
            hintText: "请再次输入密码",
            textInputAction: TextInputAction.next,
            clearable: true,
            obscureText: true,
            onChange: (v) {
              _confirmPass.text = v;
            },
          ),
          WeInput(
              label: "中文姓名",
              hintText: "请输入中文姓名",
              textInputAction: TextInputAction.next,
              onChange: (v) {
                _name.text = v;
              },
              footer: Row(
                children: [
                  WeSwitch(
                    color: themes[Provider.of<AppProvider>(context).themeColor],
                    size: 20,
                    checked: _gender == 0 ? true : false,
                    onChange: (v) {
                      setState(() {
                        _gender = v ? 0 : 1;
                      });
                    },
                  ),
                  SizedBox(width: 8,),
                  Text(
                      _gender == 0 ? '男' : '女'
                  ),
                ],
              )
          ),
          WeCell(
            label: "出生日期",
            content: getYMD(_dateTime),
            align: Alignment.center,
            footer: Row(
              children: [
                WeSwitch(
                  size: 20,
                  color: themes[Provider.of<AppProvider>(context).themeColor],
                  checked: _solar == 0 ? true : false,
                  onChange: (v) {
                    setState(() {
                      _solar = v ? 0 : 1;
                    });
                  },
                ),
                SizedBox(width: 8,),
                Text(
                  _solar == 0 ? "阳历" : "阴历",
                ),
              ],
            ),
            onClick: () async {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1980, 1, 1),
                  maxTime: DateTime(2022, 1, 1),
                  onChanged: (date) {
                    print('change $date');
                  },
                  onConfirm: (date) {
                    print('confirm $date');
                    setState(() {
                      _dateTime = date;
                    });
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.zh
              );
            },
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              child: RaisedButton(
                onPressed: _register,
                child: const Text('注册'),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _register()async {
    if (_user.text == null || _user.text.isEmpty) {
      WeToast.fail(context)(message: "账号不能为空~");
      return;
    }
    if (_pass.text == null || _pass.text.isEmpty) {
      WeToast.fail(context)(message: "密码不能为空~");
      return;
    }
    if (_confirmPass.text == null || _confirmPass.text.isEmpty) {
      WeToast.fail(context)(message: "确认密码不能为空~");
      return;
    }
    if (_confirmPass.text != _pass.text) {
      WeToast.fail(context)(message: "两次密码输入不一致~");
      return;
    }
    if (_name.text == null || _name.text.isEmpty) {
      WeToast.fail(context)(message: "姓名不能为空~");
      return;
    }

    if (_dateTime == null) {
      WeToast.fail(context)(message: "生日不能为空~");
      return;
    }
    HashMap<String, Object> params = new HashMap();
    params['username'] = _user.text;
    params['password'] = _pass.text;
    params['name'] = _name.text; // 姓名
    params['gender'] = _gender; // 性别
    params['birthday'] = getYMD(_dateTime); // 生日
    params['solar'] = _solar; // 日期类型

    print(params);
    Response result = await UserApi.register(params);
    print(result);
    if(result.data['success']) {
      //  注册成功跳转登录页面
      Navigator.of(context).popAndPushNamed("login");
    } else {
      // WeDialog.moration_day(context)(result.data['message']);
      await showAlertDialog(context, "错误", result.data['message']);
    }
  }
}
