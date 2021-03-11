import 'package:bmwquiz/model/score.dart';
import 'package:flutter/material.dart';

class FinalScore extends StatefulWidget{

  final Score? score;

  FinalScore({this.score});

  @override
  _FinalScorePageState createState() => _FinalScorePageState();

}

class _FinalScorePageState extends State<FinalScore>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Result"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Your Score is: ")
            
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

}