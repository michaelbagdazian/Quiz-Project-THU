import 'package:flutter/material.dart';

import '../../models/quiz/answer.dart';

class QuizComponent extends StatelessWidget {
  final String questionText;
  final List<Answer> answers;
  final bool buttonsActive;
  final bool showScoreScreen;
  final bool showCountdown;
  final Image? image;
  final Function onCorrectAnswer;
  final Function onWrongAnswer;
  final Function onFinishAnswer;

  const QuizComponent(
      {Key? key,
      required this.questionText,
      required this.answers,
      required this.buttonsActive,
      required this.showScoreScreen,
      required this.showCountdown,
      required this.onCorrectAnswer,
      required this.onWrongAnswer,
      required this.onFinishAnswer,
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
        if (showScoreScreen == false && showCountdown == false)
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: answers
                  .map((entry) => Container(
                        padding: const EdgeInsets.all(5),
                        child: TextButton(
                          child: Text(
                            entry.answerText,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              primary: Colors.greenAccent,
                              padding: const EdgeInsets.all(20)),
                          onPressed: buttonsActive
                              ? () {
                                  if (entry.isCorrect) {
                                    onCorrectAnswer();
                                  } else {
                                    onWrongAnswer();
                                  }
                                  onFinishAnswer();
                                }
                              : null,
                        ),
                      ))
                  .cast<Widget>()
                  .toList(),
            ),
          )
      ],
    );
  }
}
