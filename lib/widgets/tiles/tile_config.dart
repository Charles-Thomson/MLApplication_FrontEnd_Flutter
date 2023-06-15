import 'package:flutter/material.dart';


abstract class Tile{
  abstract Color primaryColor;
  abstract double tileOffSet;
  abstract double depth;

  Color get getPrimaryColor;
  double get getTileOffSet;
  double get getDepth;

}
class StartTile implements Tile{

  @override
  Color primaryColor = Colors.green;

  @override
  double depth = 10;

  @override
  double tileOffSet = 0;

  @override
  get getPrimaryColor => primaryColor;

  @override
  get getTileOffSet => tileOffSet;

  @override
  get getDepth => depth;
}

class OpenTile implements Tile{

  @override
  Color primaryColor = Colors.blueGrey;

  @override
  double depth = 10;

  @override
  double tileOffSet = 0;

  @override
  get getPrimaryColor => primaryColor;

  @override
  get getTileOffSet => tileOffSet;

  @override
  get getDepth => depth;
}

class ObstacleTile implements Tile{
  @override
  double depth = 2;

  @override
  double tileOffSet = 10;

  @override
  Color primaryColor = Colors.red;

  @override
  double get getDepth => depth;

  @override
  get getTileOffSet => tileOffSet;

  @override
  Color get getPrimaryColor => primaryColor;

}

class GoalTile implements Tile{
  @override
  double depth = 10;

  @override
  double tileOffSet = 0;

  @override
  Color primaryColor = Colors.orange;

  @override
  double get getDepth => depth;

  @override
  get getTileOffSet => tileOffSet;

  @override
  Color get getPrimaryColor => primaryColor;
}