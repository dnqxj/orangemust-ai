import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/global/Global.dart';

class LoveView extends StatefulWidget {
  const LoveView({Key key}) : super(key: key);

  @override
  _LoveViewState createState() => _LoveViewState();
}

class _LoveViewState extends State<LoveView> {
  File _image;
  final ImagePicker _picker = ImagePicker();
  List _imageList = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("恋爱图片"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: _getImage,
      ),
        // 一
        // body: _image != null ? Center(child: Image.file(_image),) : Center()
      // 二、
      // body: ListView.builder(itemBuilder: _itemBuilder, itemCount: _imageList.length,),
      body: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        padding: EdgeInsets.all(10.0),
        children: _itemListBuilder(),
      )
    );
  }

  // 方式二的数据
  Widget _itemBuilder(BuildContext context, int index) {
    return Image.network(_imageList[index]['url']);
    // List<Widget> widgets = List();
    // if (_imageList.length > 0) {
    //   for(var e in _imageList) {
    //     widgets.add(
    //         Stack(
    //           children: [
    //             Image.network(e["url"])
    //           ],
    //         )
    //     );
    //   }
    // }
  }

  // 方式三的数据
  List<Widget> _itemListBuilder() {
    List<Widget> widgets = List();
    if (_imageList.length > 0) {
      for (var e in _imageList) {
        print(e);
        widgets.add(
          Stack(
            children: [
              Image.network(
                 e["url"],
                fit: BoxFit.fill,
                width: 200,
                height: 200,
              ),
              GestureDetector(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.delete),
                ),
                onTap: () {
                  _delete(e['id']);
                },
              )
            ],
          )
        );
      }
    }

    return widgets;
  }

  void _delete(int id) {
    print(id);
  }

  void loadData() async {
    var res = await Global.getInstance().dio.get("/bookkeeping/get_images");
    print(res);
    if(res.data['status'] == 'success') {
      setState(() {
        _imageList = res.data['data'];
      });
    } else {
      EasyLoading.showError(res.data['message']);
    }
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
      path: file.path.substring(0, file.path.lastIndexOf("/"))
    );
    // 压缩
    Luban.compressImage(compressObject).then((_path) async {
      // setState(() {
      //   _image = File(_path);
      // });
      // String path = pickedFile.path;
      String filename = _path.substring(_path.lastIndexOf("/") + 1);
      var result = await Global.getInstance().dio.post(
          "/bookkeeping/update_file",
          data: FormData.fromMap({
            "file": await MultipartFile.fromFile(
                _path,
                filename: filename
            )
          })
      );

      if(result.data['status'] == 'success') {
        EasyLoading.showSuccess(result.data["msg"]);
      } else {
        EasyLoading.showError(result.data["msg"]);
      }
    });

    // 上传文件


    // 页面回显
    // if(pickedFile != null) {
    //   setState(() {
    //     _image = File(pickedFile.path);
    //   });
    // }
  }
}
