import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:flutter/material.dart';

// ! Information about the class:
// ~ This class represents ONE entry in the List
// ! Use of the class:
// ~ It's used as a template for ListView entry in screens/quizes/quiz_list.dart

// ! TODOS:
// all done

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
                // ! backGroundColor:
                // ~ If quiz is shared, it will have blue color. If quiz is private, it will have brown color
                backgroundColor: quiz.quizIsShared ? Colors.blue : Colors.brown,
                backgroundImage: AssetImage('assets/coffee_icon.png'),
              ),
              title: Text(quiz.quizTitle),
              subtitle: Text('The owner of the Quiz is ${quiz.quizOwner}')),
        ));
  }
}
