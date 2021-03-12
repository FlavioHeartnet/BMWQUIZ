// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bmwquiz/model/question.dart';
import 'package:bmwquiz/model/score.dart';
import 'package:bmwquiz/ui/finalScore.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Test FinalScore Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(FinalScore(score: Score(finalScore: 100, myAnwsers: 
      <Questions>[
        Questions(id: 1, anwser: "Germany", question: "BMW"),
        Questions(id: 2, anwser: "Japan", question: "Toyota"),
        Questions(id: 3, anwser: "Japan", question: "Mini"),
        Questions(id: 4, anwser: "England", question: "General Motors"),
        Questions(id: 5, anwser: "USA", question: "Rolls-Royce")
      ]
      )
      ));

    final searchListTree = find.text("Germany");

    expect(searchListTree, findsOneWidget);

  });
}
