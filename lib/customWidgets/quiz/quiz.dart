import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  final int number;
  final String answer;
  final List<String> questions;
  const Quiz(
      {Key? key,
      required this.questions,
      required this.answer,
      required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Expanded(child: Container(color: Colors.greenAccent)),
        SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Question $number",
                style: const TextStyle(color: Colors.white, fontSize: 40)),
            Image.network("https://picsum.photos/200"),
            Column(
              children: questions.map((e) => Text(e)).toList(),
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
