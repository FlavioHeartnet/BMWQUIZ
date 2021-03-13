import 'package:bmwquiz/ui/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'Car Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: "Car Quiz",),
    ));
}