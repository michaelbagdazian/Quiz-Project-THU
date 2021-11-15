import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  final String text;
  const QuizButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 1,
        child: TextButton(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          style: TextButton.styleFrom(
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              backgroundColor: Colors.amberAccent,
              primary: Colors.greenAccent,
              padding: const EdgeInsets.all(20)),
          onPressed: () {},
        ));
  }
}
