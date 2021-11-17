import 'package:crew_brew/components/quiz/quiz_button.dart';
import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  final int number;
  final String answer;
  final String questionText;
  final List<String> answers;
  final Image? image;
  const Quiz(
      {Key? key,
      required this.questionText,
      required this.answers,
      required this.answer,
      required this.number,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all((theme.textTheme.bodyText2!.fontSize)! *
              6), // ~Equivalent to 4 em's
          decoration: const BoxDecoration(color: Color.fromARGB(50, 0, 0, 0)),
          alignment: Alignment.center,
          child: Text(
            questionText,
            style: theme.textTheme.headline6!.copyWith(color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: answers
                .map((e) => Container(
                      padding: const EdgeInsets.all(5),
                      child: QuizButton(text: e),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
