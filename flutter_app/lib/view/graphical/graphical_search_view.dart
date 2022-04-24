import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/apis/file/index.dart' as FileApi;
import 'package:flutter_app/config/env.dart';
import 'package:flutter_app/utils/alert_utils.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_picker/image_picker.dart';

class GraphicalSearchView extends StatefulWidget {
  const GraphicalSearchView({Key key}) : super(key: key);

  @override
  State<GraphicalSearchView> createState() => _GraphicalSearchViewState();
}

class _GraphicalSearchViewState extends State<GraphicalSearchView> {
  // 声明表单控制器
  // 类型列表
  List _distinguishTypeOptions = [
    {"label": "相似图片搜索", "value": "1"},
    {"label": "相同图片搜索", "value": "2"},
    {"label": "商品图片搜索", "value": "3"},
    {"label": "绘本图片搜索", "value": "4"},
  ];
  Map _distinguishType = null;

  String _uploadImageUrlPath = null;
  final ImagePicker _picker = ImagePicker();
  String _resourcesUuid = "";

  @override
  void initState() {
    _distinguishType = {"label": "相似图片搜索", "value": "1"};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: GestureDetector(
                child: _uploadImageUrlPath == null
                    ? Container(
                        width: 300,
                        height: 150,
                        decoration: BoxDecoration(
                          // 装饰背景
                          // 背景色
                          color: Color.fromARGB(255, 251, 253, 255),
                          // 圆角
                          borderRadius: BorderRadius.circular(10),
                          // 边框
                          border: Border.all(
                            color: Colors.black26,
                            width: 1,
                          ),
                          // 阴影
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.pink,
                          //     blurRadius: 5.0
                          //   ),
                          // ],
                          // 背景图片
                          // image: DecorationImage(
                          //   image: NetworkImage("http://via.placeholder.com/350x350"),
                          //   alignment: Alignment.centerLeft
                          // )
                        ),
                        child: Icon(
                          Icons.add,
                          size: 64,
                          color: Colors.black26,
                        ),
                      )
                    : Image.network(
                        _uploadImageUrlPath,
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                onTap: _getImage,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ListTile(
              title: Text("选择分类"),
              trailing: Text(_distinguishType != null
                  ? _distinguishType['label'].toString()
                  : ''),
              onTap: _showDistinguishTypeAlert,
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: _submit,
                child: Text("识别"),
              ),
            )
          ],
        ));
  }

  Future _getImage() async {
    // _picker是ImagePicker格式，pickedFile 是PickedFile格式
    PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
    // PickedFile pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    // 图片压缩
    // 文件流
    File file = File(pickedFile.path);
    // 处理luban使用的文件信息对象
    CompressObject compressObject = CompressObject(
        imageFile: file, // image
        path: file.path.substring(0, file.path.lastIndexOf("/")));
    // 压缩
    Luban.compressImage(compressObject).then((_path) async {
      String filename = _path.substring(_path.lastIndexOf("/") + 1);
      try {
        var result = await FileApi.upload(FormData.fromMap(
            {"file": await MultipartFile.fromFile(_path, filename: filename)}));
        if (result.data['success']) {
          var data = result.data["data"];
          String uploadImageUrlPath = data["url_path"];
          String uuid = data["uuid"];
          setState(() {
            _uploadImageUrlPath = Env.envConfig.appDomain + uploadImageUrlPath;
            _resourcesUuid = uuid;
          });
        } else {
          await showAlertDialog(context, "错误", result.data['message']);
        }
      } catch (e) {
        e.toString();
        await showAlertDialog(context, "错误", "上传失败");
      }
    });
  }

  // 选择类型
  void _showDistinguishTypeAlert() async {
    var result =
        await showObjectAlertDialog(_distinguishTypeOptions, "选择分类", "label");
    if (result != null) {
      setState(() {
        _distinguishType = result;
      });
    }
  }

  void _submit() async {
    //  处理提交
    //  处理返回
    //  跳转内页
    var result =
        await Navigator.of(context).pushNamed("graphical_distinguish_result");
    // if (result != null && result == 'refresh') {
    //   loadData();
    // }
  }
}
