import 'package:flutter/material.dart';

  final colorList = <Color>[
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.brown,
    Colors.deepOrangeAccent,
    Colors.deepPurple,
    Colors.limeAccent,
    Colors.indigo,
    Colors.pinkAccent,
    Colors.redAccent,    
    Colors.yellowAccent
  ];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0, 'SelectedColor must be greater or equal than 0'),
      assert(selectedColor < colorList.length,"SelectedColor must be less than ${colorList.length}");

  ThemeData getTheme() =>
      ThemeData(
        useMaterial3: true,
        colorSchemeSeed: colorList[selectedColor],
        appBarTheme: const AppBarTheme(
          centerTitle: false
        )
      );
}
