import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/base/view.dart';
import 'package:flutter_app/apis/file/index.dart' as FileApi;
import 'package:flutter_app/config/env.dart';
import 'package:flutter_app/utils/alert_utils.dart';
import 'package:flutter_app/apis/album/index.dart' as AlbumApi;

class AlbumAddView extends StatefulWidget {
  const AlbumAddView({Key key}) : super(key: key);

  @override
  _AlbumAddViewState createState() => _AlbumAddViewState();
}

class _AlbumAddViewState extends State<AlbumAddView> {
  // 声明表单控制器
  TextEditingController _nameController;
  TextEditingController _detailsController;

  String _uploadImageUrlPath = null;
  final ImagePicker _picker = ImagePicker();
  String _resourcesUuid = "";

  @override
  void initState() {
    _nameController = new TextEditingController();
    _detailsController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("添加照片"),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入图片名称",
                ),
                textInputAction: TextInputAction.send,
                controller: _nameController,
              ),
            ),
            Container(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                maxLength: 255,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入备注",
                ),
                textInputAction: TextInputAction.send,
                controller: _detailsController,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: GestureDetector(
                child: _uploadImageUrlPath == null ? Container(
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
                ) : Image.network(_uploadImageUrlPath, height: 150, fit: BoxFit.fill,),
                onTap: _getImage,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: _submit,
                child: Text("新增"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _getImage() async {
    // _picker是ImagePicker格式，pickedFile 是PickedFile格式
    PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
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

  void _submit()async {
    if(_nameController == null || _nameController.text.isEmpty) {
      await showAlertDialog(context, "错误", "请输图片名称");
      return;
    }

    if(_detailsController == null || _detailsController.text.isEmpty) {
      await showAlertDialog(context, "错误", "请输图片备注");
      return;
    }

    if(_resourcesUuid == "") {
      await showAlertDialog(context, "错误", "请上传图片");
      return;
    }

    var params = {
      "name": _nameController.text,
      "details": _detailsController.text,
      "resourcesUuid": _resourcesUuid
    };
    var result = await AlbumApi.add(params);
    print(result);
    if(result.data["success"]) {
      Navigator.pop(context, 'refresh');
    } else {
      await showAlertDialog(context, "错误", result.data["message"]);
    }
  }
}
