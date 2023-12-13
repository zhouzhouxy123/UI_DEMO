import 'package:flutter/material.dart';
import 'package:ui_works/ui.dart';

import 'package:ui_works/renderer.dart';

void main() {
  final x = Frame(
    padding: 3,
    space: 1,
    border: 1,
    vertical: true,
    children:  [
    (1, Label(text: 'Hello World')),
    (
      3,
      Frame(vertical: false, children: [
        (1, Frame.single(Label(text: '1'))),
        (3, Frame.single(Label(text: '3'))),
      ])
    ),
    (1, Label(text: '1')),
  ]
  );
  runApp(MyHome(child: MV(viewObject: x)));
}

class MyHome extends StatelessWidget {
  final Widget child;

  const MyHome({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Works',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UI Works'),
        ),
        body: Center(
          child: child,
        ),
      ),
    );
  }
}
