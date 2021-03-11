import 'package:bmwquiz/ui/finalScore.dart';
import 'package:bmwquiz/ui/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'Car Quiz',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FinalScore(),
    ));
}