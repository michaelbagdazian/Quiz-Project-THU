import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  final String text;
  const QuizButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
      style: TextButton.styleFrom(
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.amberAccent,
          primary: Colors.greenAccent),
      onPressed: () {},
    );
  }
}
