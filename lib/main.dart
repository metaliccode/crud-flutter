import 'package:flutter/material.dart';
import 'package:toko_online/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD',
      home: HomePage(),
    );
  }
}

// dasar
// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Training Flutter',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter App'),
//         ),
//         body: Container(
//           child: Center(
//             child: Text(
//               'Test',
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
