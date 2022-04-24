import 'package:flutter/material.dart';
import 'package:flutter_app/view/graphical/graphical_distinguish_view.dart';
import 'package:flutter_app/view/graphical/graphical_search_view.dart';

class GraphicalIndexView extends StatefulWidget {
  const GraphicalIndexView({Key key}) : super(key: key);

  @override
  State<GraphicalIndexView> createState() => _GraphicalViewState();
}

class _GraphicalViewState extends State<GraphicalIndexView>
    with SingleTickerProviderStateMixin {
  List<Widget> _widgets = [];
  TabController _controller;

  @override
  void initState() {
    _widgets..add(GraphicalDistinguishView())..add(GraphicalSearchView());
    _controller = new TabController(length: _widgets.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图形AI"),
        centerTitle: true,
        elevation: 10,
        // 顶部tab页
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: "图像识别",
            ),
            Tab(
              text: "图像搜索",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: _widgets,
      ),
    );
  }
}
