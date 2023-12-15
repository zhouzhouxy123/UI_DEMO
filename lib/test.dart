import 'package:flutter/material.dart';

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
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap Gesture Example'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            counter++;
          });
        },
        child: Center(
          child: Container(
            width: 200,
            height: 100,
            color: Colors.blue,
            child: Center(
              child: Text('Tap Me: $counter'),
            ),
          ),
        ),
      ),
    );
  }
}
