import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/screens/quizzes/active_quiz.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:flutter/material.dart';

class QuizWrapper extends StatelessWidget {
  const QuizWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    if (data != null) {
      Quiz quiz = data['quiz'];
      print("quizID: " + quiz.quizID);
      return ActiveQuiz(quiz: quiz);
    } else {
      return const Loading();
    }
  }
}
