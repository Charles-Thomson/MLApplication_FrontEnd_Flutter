import 'package:flutter/material.dart';
import 'package:ann_app/pages/home_page.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = true;  // HERE FOR DESIGN BOUNDARY'S
    return MaterialApp(

      title: 'Test data',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'ANN_App_0.3'),
    );
  }
}