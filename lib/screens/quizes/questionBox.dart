/*
import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/game.dart';
import 'package:crew_brew/models/quiz/question.dart';
import 'package:flutter/material.dart';


class QuestionBox extends StatefulWidget {
  final Question testQuestion1;
  final Question testQuestion2;
  final Question testQuestion3;
  final Question testQuestion4;
  final Question testQuestion5;
  final Quiz testQuiz;
  final Game testGame;

  const QuestionBox(
      {required Key key,
      required this.testGame,
      required this.testQuiz,
      required this.testQuestion1,
      required this.testQuestion2,
      required this.testQuestion3,
      required this.testQuestion4,
      required this.testQuestion5})
      : super(key: key);

  @override
  QuestionBox_State createState() {
    return QuestionBox_State();
  }
}

class QuestionBox_State extends State<QuestionBox> {
  void nextQuestion() {
    if (widget.testGame.currentQuestion == 4) {
      widget.testGame.currentQuestion = 0;
      widget.testGame.points = 0;
    }
    setState(() {
      widget.testGame.currentQuestion++;
    });
    showNext = false;
    showCorrect = false;
    showWrong = false;
  }

  bool showNext = false;
  bool showCorrect = false;
  bool showWrong = false;

  void answer(int number) {
    setState(() {
      showNext = true;
    });
    if (widget.testQuiz.listOfQuestions[widget.testGame.currentQuestion]
            .isAnswerCorrect(number) ==
        true) {
      setState(() {
        showCorrect = true;
        widget.testGame.points++;
      });
    } else {
      setState(() {
        showWrong = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.testQuiz.listOfQuestions[widget.testGame.currentQuestion]
            .questionText),
        ElevatedButton(
          onPressed: showNext ? null : () => answer(0),
          child: Text(widget.testQuiz
              .listOfQuestions[widget.testGame.currentQuestion].answers[0]),
        ),
        ElevatedButton(
          onPressed: showNext ? null : () => answer(1),
          child: Text(widget.testQuiz
              .listOfQuestions[widget.testGame.currentQuestion].answers[1]),
        ),
        ElevatedButton(
          onPressed: showNext ? null : () => answer(2),
          child: Text(widget.testQuiz
              .listOfQuestions[widget.testGame.currentQuestion].answers[2]),
        ),
        ElevatedButton(
          onPressed: showNext ? null : () => answer(3),
          child: Text(widget.testQuiz
              .listOfQuestions[widget.testGame.currentQuestion].answers[3]),
        ),
        if (showNext == true)
          ElevatedButton(
              onPressed: () => nextQuestion(),
              child: Text("Next"),
              style: ElevatedButton.styleFrom(primary: Colors.grey)),
        if (showCorrect == true)
          Text(
            "Correct!",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        if (showWrong == true)
          Text(
            "Wrong!",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        Text("Points: ${widget.testGame.points}"),
      ],
    );
  }
}
*/
