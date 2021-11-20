import 'dart:async';

import 'package:crew_brew/components/quiz/quiz_component.dart';
import 'package:crew_brew/models/quiz/question.dart';
import 'package:flutter/material.dart';

const CORRECT_MESSAGE = "Correct";
const WRONG_MESSAGE = "Wrong";
// ~ Done by Luke

class ActiveQuiz extends StatefulWidget {
  final List<Question> questions;
  const ActiveQuiz({Key? key, required this.questions}) : super(key: key);

  @override
  _ActiveQuizState createState() => _ActiveQuizState();
}

class _ActiveQuizState extends State<ActiveQuiz> {
  int currentQuestion = 0;
  String message = "";
  void next() {
    Timer(const Duration(seconds: 2), () {
      if (currentQuestion == widget.questions.length - 1) {
        // TODO: Show Score Screen Here
        setState(() {
          currentQuestion = 0;
        });
      } else {
        setState(() {
          currentQuestion++;
        });
      }
      setState(() {
        message = "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (message != "")
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: (message == CORRECT_MESSAGE)
                          ? Colors.green
                          : Colors.red),
                  child: Text(
                    message,
                    style: theme.textTheme.bodyText2!
                        .copyWith(color: Colors.white),
                  ),
                ),
              Container(
                alignment: Alignment.center,
                padding:
                    EdgeInsets.all((theme.textTheme.bodyText2!.fontSize)! * 1),
                child: Text(
                  "Question ${currentQuestion + 1}/${widget.questions.length}",
                  style: theme.textTheme.headline4!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: QuizComponent(
                    questionText: widget.questions
                        .elementAt(currentQuestion)
                        .questionText,
                    answers:
                        widget.questions.elementAt(currentQuestion).answers,
                    answer: 1,
                    onCorrectAnswer: () {
                      // TODO: DO SOMETHING ON CORRECT ANSWER
                      print(CORRECT_MESSAGE);
                      setState(() {
                        message = CORRECT_MESSAGE;
                      });
                    },
                    onWrongAnswer: () {
                      print(WRONG_MESSAGE);

                      // TODO: DO SOMETHING ON FALSE ANSWER
                      setState(() {
                        message = WRONG_MESSAGE;
                      });
                    },
                    onFinishAnswer: next,
                  )),
            ]),
      ),
    );
  }
}
