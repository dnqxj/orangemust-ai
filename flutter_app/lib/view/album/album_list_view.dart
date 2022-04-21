import 'package:flutter/material.dart';
import 'package:flutter_app/base/view.dart';
import 'package:flutter_app/apis/album/index.dart' as AlbumApi;
import 'package:flutter_app/config/env.dart';
import 'package:flutter_app/utils/alert_utils.dart';
import 'package:flutter_app/utils/data_utils.dart';

class AlbumListView extends StatefulWidget {
  const AlbumListView({Key key}) : super(key: key);

  @override
  _AlbumListViewState createState() => _AlbumListViewState();
}

class _AlbumListViewState extends State<AlbumListView> {
  List _albumList = null;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: getAppBar("图形"),
      body: Container(
          padding: EdgeInsets.only( left: 15, right: 15),
          child: ListView.builder(
            shrinkWrap: true, // 根据子组件的高度
            itemBuilder: _itemBuilder,
            itemCount: _albumList == null ? 0 : _albumList.length,
          ) ),
      floatingActionButton: FloatingActionButton(
        heroTag:'album_add',
        child: Icon(Icons.add),
        onPressed: _add,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _itemBuilder (BuildContext context, int index) {
    const labelStyle = TextStyle(fontSize: 16, color: Colors.black87);
    const valueStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    var itemData = _albumList[index];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "名称：",
                    style: labelStyle,
                  ),
                  Text(
                    itemData["name"],
                    style: valueStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "日期：",
                    style: labelStyle,
                  ),
                  Text(
                    timeStampToYMD(itemData["createTime"]),
                    style: valueStyle,
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            children: [Text("描述："), Text(itemData["details"])],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: new Image.network(
            Env.envConfig.appDomain + itemData["urlPath"],
            fit: BoxFit.fill,
            height: 150,
          ),
        ),
        SizedBox(height: 10,),
        Divider(height: 1,),
        SizedBox(height: 10,),
      ],
    );
  }

  //  加载数据
  void loadData() async {
    var result = await AlbumApi.list();
    print(result);
    if(result.data["success"]) {
      var data = result.data["data"];
      var list = data["list"];
      setState(() {
        _albumList = list;
      });
    } else {
      await showAlertDialog(context, "错误", result.data['message']);
    }
  }

  void _add() async {
    var result = await Navigator.of(context).pushNamed("album_add");
    if (result != null && result == 'refresh') {
      loadData();
    }
  }
}
