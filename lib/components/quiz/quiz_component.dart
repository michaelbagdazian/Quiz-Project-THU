import 'package:flutter/material.dart';

class QuizComponent extends StatelessWidget {
  final String questionText;
  final List<String> answers;
  final int answer;
  final Image? image;
  final Function onCorrectAnswer;
  final Function onWrongAnswer;
  const QuizComponent(
      {Key? key,
      required this.questionText,
      required this.answers,
      required this.answer,
      required this.onCorrectAnswer,
      required this.onWrongAnswer,
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
                .asMap()
                .keys
                .map((i) => Container(
                      padding: const EdgeInsets.all(5),
                      child: TextButton(
                        child: Text(
                          answers[i],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            primary: Colors.greenAccent,
                            padding: const EdgeInsets.all(20)),
                        onPressed: () {
                          if (answer == i) {
                            onCorrectAnswer();
                          } else {
                            onWrongAnswer();
                          }
                        },
                      ),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
