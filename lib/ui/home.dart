import 'dart:async';
import 'dart:math';
import 'package:bmwquiz/model/options.dart';
import 'package:bmwquiz/model/question.dart';
import 'package:bmwquiz/model/score.dart';
import 'package:bmwquiz/ui/finalScore.dart';
import 'package:flutter/material.dart';



class MyHomePage extends StatefulWidget{
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  int score = 0;
  late List<Options> options;
  List<Questions>? questions;
  Options? selectedOptions;
  bool _visible = true;
  final _random = new Random();
  Questions? currentQuestion;
  List<Questions> questionsAnwsered = [];
  late Timer _timer;
  late AnimationController progressBarController;

  Questions getRandomQuestion() {
    return questions![_random.nextInt(questions!.length)];
  }

  _fecthAnwser(){
    _timer = Timer(Duration(milliseconds: 1000), () async {
        if(!_visible) {
          setState(() {
            _visible = true;
          });
          questionsAnwsered.add(Questions(id: currentQuestion?.id,anwser: selectedOptions?.option));
          questions!.remove(currentQuestion);
          if (selectedOptions?.option == currentQuestion?.anwser) {
            score += 20;
          }
          if (questions!.length == 0 || questions == null) {
            setState(() {
              _visible = false;
            });
            _timer.cancel(); 
            questionsAnwsered.sort((a,b) => a.id!.compareTo(b.id!));
            await _sendFinalScorePage(new Score(finalScore: score, myAnwsers: questionsAnwsered));
          } else {
            currentQuestion = getRandomQuestion();
          }
        }else{
          _timer.cancel();
        }
        selectedOptions = null;
    });
  }

  void _nextQuestion(){
    setState(() {
      _visible = false;
      _fecthAnwser();
      _initProgressBarAnimation();
        
    });
  }

  @override
  void initState(){
    super.initState();
    initQuiz();
  }

  @override
  void dispose() {
    progressBarController.dispose();
    super.dispose();
  }

  void _initProgressBarAnimation(){
    progressBarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..addListener(() {
      setState(() {
        
      });
    });
      progressBarController.forward().then((value) => {
        if(questions?.length != 0 && progressBarController.isCompleted){
          setState(()=>{
            _nextQuestion()
          })
        }
      });
      
  }

  _firstFadeInOutAnimatedQuestionLoad(){
    _timer = Timer(Duration(milliseconds: 500), () {
      setState(() {
          if(!_visible){
            _visible = true;
          }
            _timer.cancel();
      });
      });
  }

  void initQuiz() async{
    _initProgressBarAnimation();
    options = Options.getOptions();
    questions = await Questions.getAnwsers();
    setState(()  {
      questionsAnwsered = [];
      currentQuestion = getRandomQuestion();
      score = 0;
    });
    _firstFadeInOutAnimatedQuestionLoad();
  }

  setSelectedOptions(Options? option){
    setState(() {
      selectedOptions = option;
    });
  }


  List<Widget> createRadioList(){

      List<Widget> widgets = [];
      for(Options question in options){
        widgets.add(
          RadioListTile(
            value: question,
            title: Text(question.option!),
            groupValue: selectedOptions,
            onChanged: (dynamic currentOption){
              setSelectedOptions(currentOption);
            },
            selected: selectedOptions == question,
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
        title: Text(widget.title!),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 100,
                height: 100,
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  value: progressBarController.value,
                  semanticsLabel: "Timer for anwser the question",
                ),
              )
            ],
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
                      "${currentQuestion?.question}", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
        onPressed: _nextQuestion,
        tooltip: 'Save',
        child: Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _sendFinalScorePage(Score score) async{
      var navigateResult = await Navigator.push(context,MaterialPageRoute(builder: (c) => FinalScore(score: score,)));
      if(navigateResult == 'init_quiz'){
         initQuiz();
      }
  }

}

