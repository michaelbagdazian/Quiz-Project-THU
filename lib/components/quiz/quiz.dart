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
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Expanded(child: Container(color: theme.backgroundColor)),
        SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(40, 0, 0, 0),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    questionText,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: answers
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: QuizButton(text: e),
                          ),
                        )
                        .toList(),
                  )),
            )
          ],
        ))
      ]),
    );
  }
}
