import 'package:flutter/material.dart';
import 'package:ui_works/ui.dart';
import 'dart:async';

import 'package:ui_works/model.dart';
import 'package:ui_works/renderer.dart';

const int countperpage = 8;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StreamController<int> _streamController = StreamController<int>();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyState state = MyState(
      data: List.generate(
        20,
        (i) => Record(
          title: "标题${i + 1}",
          intro: "第${i + 1}个简介",
          link: "https://www.baidu.com/s?wd=${i + 1}",
        ),
      ),
    );

    UI previewList = mkPreviewList(state);

    return Scaffold(
      appBar: AppBar(
        title: Text("UI Works"),
      ),
      body: Row(
        children: [
          // 左侧导航栏
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              padding: EdgeInsets.all(8.0),
              child: MV(viewObject: previewList),
            ),
          ),
          // 右侧标题正文链接
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(8.0),
              child: StreamBuilder<int>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Placeholder for loading state
                  } else {
                    return MV(
                      viewObject: snapshot.data != null && snapshot.data! >= 0
                          ? mkDetails(state, snapshot.data!)
                          : mkDetailsPlaceholder(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  UI mkDetails(MyState state, int index) {
    if (index >= 0 && index < state.data.length) {
      Record record = state.data[index];
      return Frame(
        children: [
          (1, Label(text: record.title)),
          (1, Label(text: record.intro)),
          (1, Label(text: record.link)),
        ],
      );
    } else {
      return Label(text: "没有选中任何记录");
    }
  }

  UI mkDetailsPlaceholder() {
    // Placeholder UI when no record is selected
    return Label(text: "没有选中任何记录");
  }

  UI mkPreviewList(MyState state) {
    int start = countperpage * state.pageIndex;
    List<Record> dataToView = state.data.sublist(start, start + countperpage);
    List<Click> itemList = [
      for (Record datum in dataToView) mkPreviewItem(state, datum),
      Click(
        child: Frame(
          vertical: false,
          children: [
            (1, Label(text: "第${state.pageIndex}页")),
            (1, Label(text: "共${countperpage}条记录"))
          ],
        ),
        onClick: () {
          _streamController.add(-1);
        },
      ),
    ];
    return Frame(children: [for (Click click in itemList) (1, click)]);
  }

  Click mkPreviewItem(MyState state, Record record) {
    final click = Click(
      child: Frame(
        vertical: false,
        children: [
          (1.0, Label(text: record.title)),
        ],
      ),
      onClick: () {
        _streamController.add(state.data.indexOf(record));
      },
    );
    return click;
  }
}
