import 'package:crew_brew/models/Quiz.dart';
import 'package:flutter/material.dart';

class QuizTile extends StatelessWidget {
  const QuizTile({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                // ! The color of the quiz depends if it's shared or not
                backgroundColor: quiz.quizIsShared ? Colors.blue : Colors.brown,
                backgroundImage: AssetImage('assets/coffee_icon.png'),
              ),
              title: Text(quiz.quizTitle),
              subtitle: Text('The owner of the Quiz is ${quiz.quizOwner}')),
        ));
  }
}
