/* import 'package:flutter/material.dart';

class QuizComponent extends StatelessWidget {
  final String questionText;
  //final List<String> answers;
  final Map<String, bool> answers;
  //final int answer;
  final bool buttonsActive;
  final bool showScoreScreen;
  final bool showCountdown;
  final Image? image;
  final Function handleButtonAnswer;
  //final Function onCorrectAnswer;
  //final Function onWrongAnswer;
  //final Function onFinishAnswer;

  const QuizComponent(
      {Key? key,
      required this.questionText,
      required this.answers,
      //required this.answer,
      required this.buttonsActive,
      required this.showScoreScreen,
      required this.showCountdown,
      required this.handleButtonAnswer,
    //required this.onWrongAnswer,
    // required this.onCorrectAnswer,
    //  required this.onFinishAnswer,
      this.image})
      : super(key: key);

  void setCorrect() {

  }
  void setWrong() {

  }
  bool hasBeenPressedCorrect = false;
  bool hasBeenPressedWrong = false;

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
            //children: answers.map<Widget>((t, b) {
            children: <Widget> [
              for (var v in answers.entries)
                Container(
                      padding: const EdgeInsets.all(5),
                      child: TextButton(
                        child: Text(
                          v.key,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: hasBeenPressedCorrect ? Colors.green : hasBeenPressedWrong ? Colors.red : Colors.blueAccent,
                            primary: Colors.greenAccent,
                            padding: const EdgeInsets.all(20)),
                        onPressed: () => {
                          if (v.value == true && buttonsActive) {


                            })
                          }
                        }

                        //buttonsActive ? () =>
                        //  v.value ? setCorrect() : setWrong()
                        //    : null,
                      ),
                    ),
            ]
          ),
        )
      ],
    );
  }
}
*/
