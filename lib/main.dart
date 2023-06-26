import 'package:flutter/material.dart';
import 'package:ann_app/pages/home_page.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ann_app/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;  // HERE FOR DESIGN BOUNDARY'S
    return MaterialApp(

      title: 'Test data',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        primarySwatch: Colors.blueGrey,

        brightness: Brightness.light,
        textTheme: GoogleFonts.aBeeZeeTextTheme()
      ),
      home: const MyHomePage(title: 'ANN_App_0.3'),
    );
  }
}