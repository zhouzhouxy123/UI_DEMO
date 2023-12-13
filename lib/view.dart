import 'package:flutter/material.dart';
import 'package:ui_works/ui.dart';

import 'package:ui_works/renderer.dart';

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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final frame1 = Frame(
      padding: 3,
      space: 1,
      border: 1,
      vertical: true,
      children: [...generateTextFrames(8)],
    );
    final frame2 = Frame(
      padding: 3,
      space: 1,
      border: 1,
      vertical: true,
      children: [
        (1, Label(text: '标题')),
        (1, Label(text: '正文')),
        (1, Label(text: '链接')),
      ],
    );
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            // 左侧导航栏
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(8.0),
                child: MV(viewObject: frame1),
              ),
            ),
            // 右侧标题正文链接
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: MV(viewObject:frame2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<(double, UI)> generateTextFrames(int count) {
    return List.generate(
      count,
      (index) => (1, Frame.single(Label(text: '$index'))),
    );
  }
}

// class LeftList extends StatelessWidget{
//   final Function(int) onItemTap;

//   LeftList({required this.onItemTap});

//   @override
//   Widget build(BuildContext context){
    
//   }

// }