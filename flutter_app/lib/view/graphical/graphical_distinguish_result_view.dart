import 'package:flutter/material.dart';
import 'package:flutter_app/config/env.dart';

/**
 * 图形识别结果页面
 */
class GraphicalDistinguishResultView extends StatefulWidget {
  const GraphicalDistinguishResultView({Key key}) : super(key: key);

  @override
  State<GraphicalDistinguishResultView> createState() =>
      _GraphicalDistinguishResultViewState();
}

class _GraphicalDistinguishResultViewState
    extends State<GraphicalDistinguishResultView> {
  String _uploadImageUrlPath = null;
  List _resultList = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      _resultList.add({
        "id": i,
        "category": "植物-树",
        "confidence": (i / 2.3).toStringAsFixed(3),
        "keyword": "树",
        "describe":
            "树是一种数据结构，它是由n(n≥0)个有限节点组成一个具有层次关系的集合。把它叫做“树”是因为它看起来像一棵倒挂的树，也就是说它是根朝上，而叶朝下的。它具有以下的特点：每个节点有零个或多个子节点；没有父节点的节点称为根节点；每一个非根节点有且只有一个父节点；除了根节点外，每个子节点可以分为多个不相交的子树。"
      });
    }

    _uploadImageUrlPath = Env.envConfig.appDomain +
        "/upload/2022/04/24/664fc495ac1d8fc32f272bfe561286cd.jpg";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("识别结果"),
      ),
      // 整个页面滑动，并且页面上存在这多种不同的wiget
      body: CustomScrollView(slivers: [
        // 使用 SliverToBoxAdapter 适配box，支持customScrollView华东
        SliverToBoxAdapter(
            child: Container(
                padding: EdgeInsets.all(15),
                child: Column(children: [
                  Container(
                    child: _uploadImageUrlPath != null
                        ? Image.network(
                            _uploadImageUrlPath,
                            height: 150,
                            fit: BoxFit.fill,
                          )
                        : Container(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Divider(
                    height: 1,
                  ),
                ]))),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            _itemBuilder,
            childCount: _resultList.length,
          ),
        ),
      ]),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    const labelStyle = TextStyle(fontSize: 16, color: Colors.black87);
    const valueStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    var item = _resultList[index];

    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "类    别：",
                      style: labelStyle,
                    ),
                    Text(
                      item["category"],
                      style: valueStyle,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "置信度：",
                      style: labelStyle,
                    ),
                    Text(
                      item["confidence"].toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "关键字：",
                  style: labelStyle,
                ),
                Text(
                  item["keyword"],
                  style: valueStyle,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "描    述：",
                  style: labelStyle,
                ),
                Expanded(
                  child: Text(
                    item["describe"],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
