import 'package:flutter/material.dart';
import 'quiz.dart';

// ~ This is a template for QuoteCard, which we can later reuse
class QuizCard extends StatelessWidget {

  final Quiz quiz;
  // ~ So if we now will refer to this function from this class, it will actually run the code in the file main.dart
  // ~ were we have access to the data
  final Function() delete;
  QuizCard({ required this.quiz, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Quote text
            Text(
              quiz.quizName,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 6.0),
            // Author
            Text(
              quiz.author,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8.0),
            FlatButton.icon(
              // ~ This will call the delete function, and code will be executed from main.dart
                onPressed: delete,
                icon: Icon(Icons.delete),
                label: Text('delete quiz')),
          ],
        ),
      ),
    );
  }
}