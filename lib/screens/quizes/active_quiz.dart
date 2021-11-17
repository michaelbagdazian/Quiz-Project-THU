import 'dart:ffi';

import 'package:crew_brew/components/quiz/quiz.dart';
import 'package:flutter/material.dart';

class ActiveQuiz extends StatefulWidget {
  final List<Quiz> questions;
  const ActiveQuiz({Key? key, required this.questions}) : super(key: key);

  @override
  _ActiveQuizState createState() => _ActiveQuizState();
}

class _ActiveQuizState extends State<ActiveQuiz> {
  int currentQuestion = 0;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SizedBox.expand(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // const Flexible(flex: 1, child: Text("data")),
            widget.questions.elementAt(currentQuestion),
            // Flexible(
            //     child: TextButton(
            //   onPressed: () {},
            //   child: Text("Submit"),
            // ))
          ],
        )),
      ),
    );
  }
}
