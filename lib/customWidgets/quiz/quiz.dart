import 'package:flutter/material.dart';
import 'package:test_pro/customWidgets/quiz/quiz_button.dart';

class Quiz extends StatelessWidget {
  final int number;
  final String answer;
  final List<String> questions;
  final Image? image;
  const Quiz(
      {Key? key,
      required this.questions,
      required this.answer,
      required this.number,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Expanded(child: Container(color: Colors.deepPurple[400])),
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
                  child: const Text(
                    "This is Some Text. Something long so that we can see the full question and whatnot? Maybe even longer for them big mother fuckers and stuff that would be really fucking long",
                    style: TextStyle(fontSize: 20, color: Colors.white),
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
                    children: questions
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

// Material(
//         child: Stack(
//       fit: StackFit.expand,
//       children: [
//         Expanded(
//             child: Container(color: Colors.greenAccent)), // Background Color
//         SafeArea(
//             child: Column(
//           children: [
//             Text(
//               "Question $number",
//               style: const TextStyle(color: Colors.white, decoration: null),
//             ),
//             Image.network(
//               "https://picsum.photos/200",
//             )
//           ],
//         ))
//       ],
//     ));
