import 'package:flutter_app/global/Global.dart';

var dio = Global.getInstance().dio;

// 获取账务类型
Future bookeepType()async {
  return await Global.getInstance().dio.get("/options/bookeep_type");
}


// 根据类型，获取分类
Future classify(data)async {
  return await Global.getInstance().dio.get("/options/classify", queryParameters: data);
}