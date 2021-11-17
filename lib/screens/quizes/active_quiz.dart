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
      body: SafeArea(
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Satan"),
              Flexible(
                  flex: 1, child: widget.questions.elementAt(currentQuestion)),
              TextButton(onPressed: () {}, child: const Text("Submit"))
            ]),
      ),
    );
  }
}
