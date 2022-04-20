import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TextDemo extends StatefulWidget {
  const TextDemo({Key key}) : super(key: key);

  @override
  _TextDemoState createState() => _TextDemoState();
}

class _TextDemoState extends State<TextDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Column(
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
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: RaisedButton(
              child: Text(
                "记账",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("accounting");
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: RaisedButton(
              child: Text(
                "相册",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("love");
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: RaisedButton(
                child: Text(
                  "日期提醒",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("dateAlert");
                }),
          )
        ],
      ),
    );
  }
}

// {
//   "id": 12,
//   "uid": 2,
//   "type": "expenditure",
//   "total": 100.01,
//   "classify": "看电影",
//   "details": "和妹妹去看电影",
//   "year": 2022,
//   "month": 4,
//   "day": 10,
//   "createTime": 1649605464,
//   "updateTime": 1649605464
// }
//
// Example: flutter textarea input
// TextField(
// keyboardType: TextInputType.multiline,
// textInputAction: TextInputAction.newline,
// minLines: 1,
// maxLines: 5,
// )
