import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  final String text;
  const QuizButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(text),
      color: Colors.amber,
      onPressed: () => print("Fuck you"),
    );
  }
}
