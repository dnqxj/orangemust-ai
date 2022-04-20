import 'package:flutter_app/global/Global.dart';

var dio = Global.getInstance().dio;

/**
 * 相册模块
 */
// 查询相册列表数据
Future list()async {
  return await Global.getInstance().dio.get("/album/list");
}

// 添加图片到相册
Future add(data)async {
  return await Global.getInstance().dio.post("/album/add", data: data);
}

// 删除图片
Future delete(data)async {
  return await Global.getInstance().dio.post("/bookeep/delete", data: data);
}