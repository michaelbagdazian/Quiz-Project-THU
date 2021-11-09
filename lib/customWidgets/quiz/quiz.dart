import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  const Quiz({Key? key, required List<String> questions, required answer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(child: Container(color: Colors.greenAccent)),
        ListView()
      ],
    );
  }
}
