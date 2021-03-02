import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:bmwquiz/options.dart';
import 'package:bmwquiz/question.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'BMW QUIZ'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int score = 0;
  List<Options> options;
  List<Questions> questions;
  Options selectedOptions;
  bool _visible = true;
  bool _visibleResult = false;
  final _random = new Random();
  Questions elementQuestion = new Questions(id: 0,question: "",anwser: "");
  List<Questions> questionsAnwsered;
  Timer _timer;

  _startTimer(){
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if(!_visible) {
          _visible = true;
          if (selectedOptions.option == elementQuestion.anwser) {
            score += 20;
          }
          questions.remove(elementQuestion);
          if (questions.length == 0 || questions == null) {
            _visible = false;
            print("Sua pontuação é: ${score}");
            _visibleResult = true;
            _timer.cancel();
          } else {
            elementQuestion = questions[_random.nextInt(questions.length)];
          }
        }else{
          _timer.cancel();
        }
      });
    });
  }

  void _saveAnser(){
    setState(() {
      _visible = false;
      if(!_visibleResult) {
        _startTimer();
      }
    });

  }

  @override
  void initState(){
    super.initState();
    options = Options.getOptions();
    initQuiz();
  }

  void initQuiz() async{
    questions = await Questions.getAnwsers();
    setState(()  {
      elementQuestion = questions[_random.nextInt(questions.length)];
      score = 0;
      _visibleResult = false;
      _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
        setState(() {
          if(!_visible){
            _visible = true;
            _timer.cancel();
          }else{
            _timer.cancel();
          }
        });
      });

    });

  }

  setSelectedOptions(Options q){
    setState(() {
      selectedOptions = q;
    });
  }


  List<Widget> createRadioList(){

      List<Widget> widgets = [];
      for(Options q in options){
        widgets.add(
          RadioListTile(
            value: q,
            title: Text(q.option),
            groupValue: selectedOptions,
            onChanged: (currentOption){
              setSelectedOptions(currentOption);
            },
            selected: selectedOptions == q,
          )
        );
      }

      return widgets;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                initQuiz();
              },
              child: Icon(
                Icons.refresh
              ),
            ),
          )
        ],
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          AnimatedOpacity(
            opacity: _visibleResult ? 1.0 : 0.0,
            duration: Duration(milliseconds: 100),
            child: Container(
              padding: EdgeInsets.all(24.0),
              child: Text("Your Score is: ${score}%",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(24),
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Which country belong the company: ${elementQuestion.question} ?", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    children: createRadioList(),
                  ),
                ],
              ),
            ),

          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveAnser,
        tooltip: 'Save',
        child: Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

