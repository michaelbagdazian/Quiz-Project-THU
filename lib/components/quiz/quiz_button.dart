import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  final String text;
  const QuizButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextButton(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      style: TextButton.styleFrom(
          backgroundColor:
              theme.buttonTheme.colorScheme?.secondary ?? Colors.blueAccent,
          primary: Colors.greenAccent,
          padding: const EdgeInsets.all(20)),
      onPressed: () {},
    );
  }
}
