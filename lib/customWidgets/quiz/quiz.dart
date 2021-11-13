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
        Expanded(child: Container(color: Colors.greenAccent)),
        SafeArea(
            child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Question $number",
                style: const TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Image.network("https://picsum.photos/200"),
            ),
            Column(
              children: questions.map((e) => QuizButton(text: e)).toList(),
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
