import 'package:flutter/material.dart';

class QuizButtonBack extends StatelessWidget {
  final String buttonText;
  final bool isActive;

  const QuizButtonBack(
      {Key? key,
        required this.buttonText,
        required this.isActive,
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: () => Navigator.pushReplacementNamed(context, '/sharedQuizes'),
        //onPressed: () => onPressed,
        child: Text(buttonText,
          style: const TextStyle(
              color: Colors.white, fontSize: 20),
        ),
        style: TextButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            primary: Colors.greenAccent,
            padding: const EdgeInsets.all(20)
        ),
      ),
    );
  }
}
