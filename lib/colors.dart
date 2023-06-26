import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryValue, <int, Color>{
  50: Color(0xFFF3F8FC),
  100: Color(0xFFE2EEF8),
  200: Color(0xFFCFE2F4),
  300: Color(0xFFBCD6EF),
  400: Color(0xFFADCEEB),
  500: Color(_primaryValue),
  600: Color(0xFF97BFE5),
  700: Color(0xFF8DB8E2),
  800: Color(0xFF83B0DE),
  900: Color(0xFF72A3D8),
});
 const int _primaryValue = 0xFF9FC5E8;

 const MaterialColor accent = MaterialColor(_accentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_accentValue),
  400: Color(0xFFEEF6FF),
  700: Color(0xFFD4E9FF),
});
 const int _accentValue = 0xFFFFFFFF;