// import 'package:flutter/material.dart';
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Details App'),
//         ),
//         body: DetailsScreen(),
//       ),
//     );
//   }
// }

// class DetailsScreen extends StatefulWidget {
//   @override
//   _DetailsScreenState createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
//   String selectedTitle = "No Selection";

//   void onTileSelected(String title) {
//     setState(() {
//       selectedTitle = title;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//         children: [
//           // Left Column (List of Tiles)
//         Container(
//           width: 200.0, // Adjust the width as needed
//           child: ListView(
//             children: [
//           ListTile(
//                 title: Text('Item 1'),
//                 onTap: () => onTileSelected('Item 1'),
//               ),
//               ListTile(
//                 title: Text('Item 2'),
//                 onTap: () => onTileSelected('Item 2'),
//               ),
//               // Add more ListTiles as needed
//             ],
//           ),
//         ),
//         // Right Container (Details)
//         Expanded(
//           child: Container(
//             padding: EdgeInsets.all(16.0),
//             color: Colors.grey[200],
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//                   'Details:',
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//             SizedBox(height: 10.0),
//             Text(selectedTitle),
//                 // Add more details widgets as needed
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class MyState {
//   int recordIndex = -1;
//   int pageIndex = 0;
//   List<Record> data = []; // Initialize your data
// }

// class Record {
//   String title;
//   String intro;
//   String link;

//   Record(this.title, this.intro, this.link);
// }

// class UI {}

// class Frame extends StatelessWidget {
//   final bool vertical;
//   final List<dynamic> children;

//   Frame({required this.vertical, required this.children});

//   @override
//   Widget build(BuildContext context) {
//     return vertical
//         ? Column(
//             children: _buildChildren(),
//           )
//         : Row(
//             children: _buildChildren(),
//           );
//   }

//   List<Widget> _buildChildren() {
//     return [
//       for (var entry in children)
//         entry is Map
//             ? Expanded(
//                 flex: entry['weight'],
//                 child: entry['UI'],
//               )
//             : entry is Click
//                 ? GestureDetector(
//                     onTap: entry.onClick,
//                     child: entry.child,
//                   )
//                 : Container(),
//     ];
//   }
// }

// class Label extends StatelessWidget {
//   final String text;

//   Label({required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Text(text);
//   }
// }
