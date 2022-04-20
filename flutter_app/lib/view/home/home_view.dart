import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_app/base/view.dart';
import 'package:flutter_app/provider/app_provider.dart';
import 'package:flutter_app/utils/data_utils.dart';
import 'package:provider/provider.dart';
import 'package:weui/cell/index.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    // 获取全局状态数据，用户数据
    final appProvider = Provider.of<AppProvider>(context);
    var userInfo = appProvider.userInfo;
    return Scaffold(
      appBar: getAppBarActions("菜单", [
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed("theme");
            })
      ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // 状态栏，空白问题
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userInfo["name"]),
              accountEmail: Text(userInfo["email"]),
              // currentAccountPicture: Text("data"),
            ),
            Divider(
              height: 1,
            ),
            WeCell(
              label: "注册日期",
              content: timeStampToYMD(userInfo["createTime"]),
              onClick: () {
                Navigator.pop(context);
              },
            ),
            WeCell(
              label: "支出上限",
              content: userInfo["money"].toString(),
              footer: Icon(Icons.navigate_next),
              onClick: () {},
            ),
            Divider(
              height: 1,
            ),
            WeCell(
              label: "恋爱对象",
              content: "设置对象",
              footer: Icon(Icons.navigate_next),
              onClick: () {
                // to-do 设置对象
                // Navigator.of(context).pushNamed("accounting");
              },
            ),
            Divider(
              height: 1,
            ),
            WeCell(
              label: "退出登录",
              content: "",
              footer: Icon(Icons.exit_to_app),
              onClick: () async {
                context.read<AppProvider>().logout();
                Navigator.of(context).popAndPushNamed("login");
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  "http://via.placeholder.com/350x350",
                  fit: BoxFit.fill,
                );
              },
              itemCount: 3,
              pagination: new SwiperPagination(),
              control: new SwiperControl(),
            ),
          ),
        ],
      ),
    );
  }
}
