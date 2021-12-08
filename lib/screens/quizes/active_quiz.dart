import 'dart:async';

import 'package:crew_brew/components/quiz/quiz_button_back.dart';
import 'package:crew_brew/components/quiz/quiz_component.dart';
import 'package:crew_brew/models/quiz/game_state.dart';
import 'package:crew_brew/models/quiz/question.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/colors.dart';

const CORRECT_MESSAGE = "Correct";
const WRONG_MESSAGE = "Wrong";
// ~ Done by Luke & Holger

class ActiveQuiz extends StatefulWidget {
  final List<Question> questions;
  GameState state = GameState(id: 1, players: List.filled(4, 0), playerPoints: [List.filled(4, 0)], answerTimes: [List.filled(4, 0)], answerCorrect: [List.filled(4, false)]);
  late int myPlayerNumber = getMyPlayerNumber();
  ActiveQuiz({Key? key, required this.questions}) : super(key: key);

  @override
  _ActiveQuizState createState() => _ActiveQuizState();

  int getMyPlayerNumber() {
    for (int i = 0; i < state.players.length; i++) {
      if (state.players[i] == 0) {
        state.players[i] == 1;
        return i;
      }
    }
    return -1;
    //TODO: must have a way to handle spectators i.e. players not in list an catch potential errors
  }
}

class _ActiveQuizState extends State<ActiveQuiz> {

  @override
  void initState() {
    countdown().then((value){
      print('Async done');
    });
    super.initState();
  }

  String message = "";
  int countdownTime = 3;
  Duration timeToAnswer = const Duration(seconds: 10);

  int getMyPlayerNumber() {
    for (int i = 0; i < widget.state.players.length; i++) {
      if (widget.state.players[i] == 0) {
        widget.state.players[i] == 1;
        return i;
      }
    }
    return -1;
  }
/*  int currentQuestion = 0;
  int points = 0;
  List answerTimes = [];
  List answerCorrect = [];
  bool showScoreScreen = false;
  bool buttonsActive = true;
  bool showCountdown = true;
  bool showTimeUntilAnswer = false;*/

  Stopwatch measureTime = Stopwatch();
  Duration timeElapsed = Duration();
  late Timer updateProgress;
  double timerProgress = 1;

  void next() {
    updateProgress.cancel();
    state.set   (measureTime.elapsed.inMilliseconds);
    setState(() {
      buttonsActive = false;
      showTimeUntilAnswer = true;
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
      setState(() {
        message = "";
      });
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
      const Duration(seconds: 1), (timer) {
        timerProgress = timerProgress - 0.1;
        setState(() {
          timerProgress;
        });
        if (timerProgress <= 0) {
          updateProgress.cancel();
          setState(() {
            message = WRONG_MESSAGE;
          });
          answerCorrect.add(0);
          timerProgress = 1;
          next();
        }
      },
    );
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
              if (message != "")
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: (message == CORRECT_MESSAGE)
                          ? right
                          : wrong),
                  child: Text(
                    message,
                    style: theme.textTheme.bodyText2!
                        .copyWith(color: texts),
                  ),
                ),
              Container(
                alignment: Alignment.center,
                padding:
                    EdgeInsets.all((theme.textTheme.bodyText2!.fontSize)! * 1),
                child: Text(
                  "Question ${currentQuestion + 1}/${widget.questions.length}",
                  style: theme.textTheme.headline4!.copyWith(
                    color: texts,
                  ),
                ),
              ),
              //if (showScoreScreen == false)
                Flexible(
                  flex: 1,
                  child: QuizComponent(
                    questionText:
                      showScoreScreen ? "You got $points points!\nYour time: ${answerTimes.toString()}ms\nYour answers: ${answerCorrect.toString()}bool":
                      showCountdown ? "Starting in $countdownTime" :
                      widget.questions
                        .elementAt(currentQuestion)
                        .questionText,
                    answers:
                        widget.questions.elementAt(currentQuestion).answers,
                    answer: widget.questions.elementAt(currentQuestion).correctAnswer,
                    onCorrectAnswer: () {
                      points++;
                      answerCorrect.add(1);
                      setState(() {
                        message = CORRECT_MESSAGE;
                      });
                    },
                    onWrongAnswer: () {
                      answerCorrect.add(0);
                      setState(() {
                        message = WRONG_MESSAGE;
                      });
                    },
                    onFinishAnswer: next,
                    buttonsActive: buttonsActive,
                    showScoreScreen: showScoreScreen,
                    showCountdown: showCountdown,

                  )),
              if (showTimeUntilAnswer == true)
                Text("Time elapsed: ${measureTime.elapsed.inMilliseconds.toString()} ms"),
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
