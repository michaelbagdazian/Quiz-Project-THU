import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  final String text;
  const QuizButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.tealAccent),
    );
  }
}
