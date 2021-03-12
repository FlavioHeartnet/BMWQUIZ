import 'package:bmwquiz/model/question.dart';
import 'package:bmwquiz/model/score.dart';
import 'package:flutter/material.dart';

class FinalScore extends StatefulWidget{

  final Score score;
  

  FinalScore({required this.score});

  @override
  _FinalScorePageState createState() => _FinalScorePageState();

}

class _FinalScorePageState extends State<FinalScore>{

List<Questions>? rightAnwsers;

  _loadRightAnwsers() async{
     return await Questions.getAnwsers();   
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Result"),
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
              child: Text("Your Score is: ${widget.score.finalScore}%", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              padding: EdgeInsets.fromLTRB(0,16,0,0),
              )
            ),
            Flexible(
              flex: 2,
              child: _createDynamicListView()
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

   List<Widget> _listFinalResultItens(int index, List<Questions>? rightAnwsers){
   return <Widget>[
            Flexible(flex: 4,child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text("${rightAnwsers?[index].question}", style: TextStyle(fontSize: 16),textAlign: TextAlign.start,),
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text("Anwser: ${widget.score.myAnwsers[index].anwser}", style: TextStyle(fontSize: 16)),
                )
              ],
            )),
            Flexible(flex: 1,child: Container(
              alignment: Alignment.topRight,
              child: rightAnwsers?[index].anwser ==  widget.score.myAnwsers[index].anwser ? Icon(Icons.check, color: Colors.green) : Icon(Icons.cancel_rounded, color: Colors.red)
            )
            )
          ];
 }

  Widget _createDynamicListView(){
    return FutureBuilder(
                future: _loadRightAnwsers(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                 if(snapshot.hasData){ 
                 return ListView.builder(
                    padding: EdgeInsets.all(40),
                    itemExtent: 80,
                    itemCount: widget.score.myAnwsers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: _listFinalResultItens(index, snapshot.data),
                      );
                    },
                  );
                 }
                 else if (snapshot.hasError){
                    return Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Sometihng went wrong :(  ${snapshot.error}'),
                        )
                      ],
                    );
                 }else{
                   return SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    );
                 }
                },
              );
  }

}