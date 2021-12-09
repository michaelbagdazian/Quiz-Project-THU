import 'dart:async';

import 'package:crew_brew/components/quiz/quiz_button_back.dart';
import 'package:crew_brew/components/quiz/quiz_component.dart';
import 'package:crew_brew/models/quiz/answer.dart';
import 'package:crew_brew/models/quiz/question.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/colors.dart';


class ActiveQuiz extends StatefulWidget {
  final List<Question> questions;
  const ActiveQuiz({Key? key, required this.questions}) : super(key: key);

  @override
  _ActiveQuizState createState() => _ActiveQuizState();
}

class _ActiveQuizState extends State<ActiveQuiz> {
  @override
  void initState() {
    countdown().then((value) {
      print('Async done');
    });
    super.initState();
  }

  int currentQuestion = 0;
  String message = "";

  int points = 0;
  List answerTimes = [];
  List answerCorrect = [];

  int countdownTime = 3;

  Duration timeToAnswer = const Duration(seconds: 10);

  bool showScoreScreen = false;
  bool buttonsActive = true;
  bool showCountdown = true;
  bool showTimeUntilAnswer = false;
  //questions.entries.map( (entry) => Answer(entry.key, entry.value)).toList();

  late List<bool> hasBeenPressedCorrect = List.filled(widget.questions.length, false);
  late List<bool> hasBeenPressedWrong = List.filled(widget.questions.length, false);
  int iterator = 0;

  Stopwatch measureTime = Stopwatch();
  Duration timeElapsed = Duration();
  late Timer updateProgress;
  double timerProgress = 1;

  void next() {
    updateProgress.cancel();
    answerTimes.add(measureTime.elapsed.inMilliseconds);
    setState(() {
      buttonsActive = false;
      showTimeUntilAnswer = true;

     // hasBeenPressedCorrect = false;
     // hasBeenPressedWrong = false;
    });

    //buttonsActive = false;
    //showTimeToAnswer = true;
    Timer(const Duration(seconds: 2), () {
      measureTime.reset();
      timerProgress = 1;
      if (currentQuestion == widget.questions.length - 1) {
        setState(() {
          showScoreScreen = true;
          showTimeUntilAnswer = false;
        });
      } else {
        startTimer();
        setState(() {
          currentQuestion++;
          buttonsActive = true;
          showTimeUntilAnswer = false;
        });
      }
      //setState(() {
       // message = "";
      //});
    });
  }

  Future countdown() async {
    int seconds = 0;
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        seconds++;
        setState(() {
          countdownTime--;
        });
        if (seconds > 3) {
          timer.cancel();
          setState(() {
            countdownTime = 0;
            showCountdown = false;
            measureTime.start();
            startTimer();
          });
        }
      },
    );
  }

  void startTimer() {
    updateProgress = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        timerProgress = timerProgress - 0.1;
        setState(() {
          timerProgress;
        });
        if (timerProgress <= 0) {
          updateProgress.cancel();
          setState(() {
            // do something
          });
          answerCorrect.add(0);
          timerProgress = 1;
          next();
        }
      },
    );
  }
void handleAnswerButtons() {

}

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
/*              if (message != "")
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: (message == CORRECT_MESSAGE) ? right : wrong),
                  child: Text(
                    message,
                    style: theme.textTheme.bodyText2!.copyWith(color: texts),
                  ),
                ),*/
              Container(
                alignment: Alignment.center,
                padding:
                    EdgeInsets.all((theme.textTheme.bodyText2!.fontSize)! * 1),
                child: Text("Question ${currentQuestion + 1}/${widget.questions.length}",
                  style: theme.textTheme.headline4!.copyWith(
                    color: texts,
                  ),
                ),
              ),
              //if (showScoreScreen == false)
          Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all((theme.textTheme.bodyText2!.fontSize)! *
                    6), // ~Equivalent to 4 em's
                decoration: const BoxDecoration(color: Color.fromARGB(50, 0, 0, 0)),
                alignment: Alignment.center,
                child: Text( showCountdown ? "Starting in $countdownTime" :
                    widget.questions.elementAt(currentQuestion).questionText,
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
                      children:
                        <Widget> [
                        //for (var v in widget.questions.elementAt(currentQuestion).answers.entries)
                        for (int i = 0; i < widget.questions.elementAt(currentQuestion).answers.length; i++ )
                        Container(
                            padding: const EdgeInsets.all(5),
                            child: TextButton(
                                child: Text(
                                  widget.questions.elementAt(currentQuestion).answers.i,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: hasBeenPressedCorrect ? Colors.green : hasBeenPressedWrong ? Colors.red : Colors.blueAccent,
                                    primary: Colors.greenAccent,
                                    padding: const EdgeInsets.all(20)),
                                onPressed: () => {
                                  if (v.value == true && buttonsActive) {
                                    setState(() {
                                      hasBeenPressedCorrect[widget.questions.elementAt(currentQuestion).answers.indexOf(v)] = true;
                                    })
                                  }
                                  else if (v.value == false && buttonsActive) {
                                    setState(() {
                                      hasBeenPressedWrong = true;
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
          ),
             /* Flexible(
                  flex: 1,
                  child: QuizComponent(
                    questionText: showScoreScreen
                        ? "You got $points points!\nYour time: ${answerTimes.toString()}ms\nYour answers: ${answerCorrect.toString()}bool"
                        : showCountdown
                            ? "Starting in $countdownTime"
                            : widget.questions
                                .elementAt(currentQuestion)
                                .questionText,
                    answers:
                        widget.questions.elementAt(currentQuestion).answers,
                    handleButtonAnswer: () => handleAnswerButtons(),
                    //onFinishAnswer: next,
                    buttonsActive: buttonsActive,

                    showScoreScreen: showScoreScreen,
                    showCountdown: showCountdown,
                  )*/
              if (showTimeUntilAnswer == true)
                Text(
                    "Time elapsed: ${measureTime.elapsed.inMilliseconds.toString()} ms"),
              Text("Progress indicator: ${(timerProgress * 100)} %"),

              if (showCountdown == false && showScoreScreen == false)
                LinearProgressIndicator(
                  value: timerProgress,
                  minHeight: 15,
                ),

              const QuizButtonBack(buttonText: "back", isActive: true),

              //Text("Time elapsed: $currentTime")
            ]),
      ),
    );
  }
}
