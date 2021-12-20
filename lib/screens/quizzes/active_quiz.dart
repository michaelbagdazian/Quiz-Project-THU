import 'dart:async';
import 'package:crew_brew/models/quiz/game_state.dart';
import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/colors.dart';

//const CORRECT_MESSAGE = "Correct";
//const WRONG_MESSAGE = "Wrong";
// ~ Done by Luke & Holger

class ActiveQuiz extends StatefulWidget {
  //final List<Question> questions;
  final Quiz quiz;
  GameState stateVector = GameState(
      id: 1,
      players: List.filled(4, 0),
      playerPoints: [List.filled(8, 0)],
      answerTimes: [List.filled(4, 0)],
      answerCorrect: [List.filled(4, false)],
      buttonsPressed: [List.filled(4, false)],
      buttonsPressedCorrect: [List.filled(4, false)]
  );
  // for later with multiplayer
  //late int myPlayerNumber = getMyPlayerNumber():

  final int myPlayerNumber = 0;
  Stopwatch measureTime = Stopwatch();
  late Timer updateProgress;

  ActiveQuiz({Key? key, required this.quiz}) : super(key: key);

  @override
  _ActiveQuizState createState() => _ActiveQuizState();

  int getMyPlayerNumber() {
    for (int i = 0; i < stateVector.players.length; i++) {
      if (stateVector.players[i] == 0) {
        stateVector.players[i] == 1;
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
     //widget.updateProgress = Timer.periodic(const Duration(seconds: 1), (timer) {

     //});
     widget.measureTime.start();
     startTimer();
 //    startTimer().then((value){
//      print('Async done');
//     });
      super.initState();
   }

  //String message = "";
  int countdownTime = 3;
  //Duration timeToAnswer = const Duration(seconds: 10);
//  Stopwatch measureTime = Stopwatch();
//  Duration timeElapsed = Duration();
  //late Timer updateProgress;
  double timerProgress = 1;

/*  int getMyPlayerNumber() {
    for (int i = 0; i < widget.stateVector.players.length; i++) {
      if (widget.stateVector.players[i] == 0) {
        widget.stateVector.players[i] == 1;
        return i;
      }
    }
    return -1;
  }*/
/*  int currentQuestion = 0;
  int points = 0;
  List answerTimes = [];
  List answerCorrect = [];
  bool showScoreScreen = false;
  bool buttonsActive = true;
  bool showCountdown = true;
  bool showTimeUntilAnswer = false;*/



  void next() {
    widget.updateProgress.cancel();
    widget.stateVector.setAnswerTimes(widget.myPlayerNumber, widget.stateVector.currentQuestion, widget.measureTime.elapsed.inMilliseconds);

    for (int j = 0; j < 4; j++) {
      if (widget.stateVector.buttonsPressed[widget.myPlayerNumber][j] && widget.quiz.listOfQuestions[widget.stateVector.currentQuestion].answers[j].isCorrect) {
        widget.stateVector.buttonsPressedCorrect[widget.myPlayerNumber][j] = true;
        widget.stateVector.playerPoints[widget.myPlayerNumber][widget.stateVector.currentQuestion]++;
      }
      if (widget.stateVector.buttonsPressed[widget.myPlayerNumber][j] && !widget.quiz.listOfQuestions[widget.stateVector.currentQuestion].answers[j].isCorrect) {
        widget.stateVector.playerPoints[widget.myPlayerNumber][widget.stateVector.currentQuestion]--;
        if (widget.stateVector.playerPoints[widget.myPlayerNumber][widget.stateVector.currentQuestion] < 0) {
          widget.stateVector.playerPoints[widget.myPlayerNumber][widget.stateVector.currentQuestion] = 0;
        }
      }
    }
    setState(() {
      widget.stateVector.buttonsActive = false;
      widget.stateVector.showTimeUntilAnswer = true;
      widget.stateVector.buttonsPressedCorrect;

    });

    //buttonsActive = false;
    //showTimeToAnswer = true;
    Timer(const Duration(seconds: 3), () {
      widget.measureTime.reset();
      timerProgress = 1;
      if (widget.stateVector.currentQuestion == widget.quiz.listOfQuestions.length - 1) {
        //route to result.dart with stateVector
        QuizState results = QuizState(quiz: widget.quiz, stateVector: widget.stateVector);
        Navigator.pushNamed(context, '/results', arguments: results);
      } else {
        startTimer();
        setState(() {
          widget.stateVector.currentQuestion++;
          widget.stateVector.buttonsActive = true;
          widget.stateVector.buttonsPressed = [List.filled(4, false)];
          widget.stateVector.buttonsPressedCorrect = [List.filled(4, false)];
          widget.stateVector.showTimeUntilAnswer = false;
        });
      }
    });
  }

/*  Future countdown() async {
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
            widget.stateVector.showCountdown = false;
            measureTime.start();
            startTimer();
          });
        }
      },
    );
  }*/
  startTimer() {
    widget.updateProgress = Timer.periodic(
      const Duration(seconds: 1), (timer) {
      timerProgress = timerProgress - 0.1;
      setState(() {
        timerProgress;
      });
      if (timerProgress <= 0) {
        widget.updateProgress.cancel();
        //answerCorrect.add(0);
        widget.stateVector.setAnswerCorrect(widget.myPlayerNumber, widget.stateVector.currentQuestion, false);
        timerProgress = 1;
        next();
      }
    },
    );
  }
void answer(int number) {
    setState(() {
      widget.stateVector.buttonsPressed[widget.myPlayerNumber][number] = !(widget.stateVector.buttonsPressed[widget.myPlayerNumber][number]);
      widget.stateVector = widget.stateVector;
    });
}

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child:
            Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Container(
                alignment: Alignment.center,
                padding:
                EdgeInsets.all((theme.textTheme.bodyText2!.fontSize)! * 1),
                child: Text(
                  "Question ${widget.stateVector.currentQuestion + 1}/${widget.quiz.listOfQuestions.length}",
                  style: theme.textTheme.headline4!.copyWith(
                    color: texts,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all((theme.textTheme.bodyText2!.fontSize)! *
                    6), // ~Equivalent to 4 em's
                decoration: const BoxDecoration(color: Color.fromARGB(50, 0, 0, 0)),
                alignment: Alignment.center,
                child: Text(
                  widget.quiz.listOfQuestions[widget.stateVector.currentQuestion].questionText,
                  style: theme.textTheme.headline6!.copyWith(color: Colors.white),
                ),
              ),
              ListView(

                children: <Widget>[
                  for (var i = 0; i <widget.quiz.listOfQuestions[widget.stateVector.currentQuestion].answers.length; i++)
                    Padding(
                        padding: const EdgeInsets.all(2),
                        child: ElevatedButton(
                        onPressed: widget.stateVector.buttonsActive ? () => answer(i) : null,
                        child: Text(widget.quiz.listOfQuestions[widget.stateVector.currentQuestion].answers[i].answerText),
                        style: TextButton.styleFrom(
                          backgroundColor: widget.stateVector.buttonsActive ?
                            widget.stateVector.buttonsPressed[widget.myPlayerNumber][i] ? Colors.yellowAccent :  Colors.blueAccent :
                          widget.stateVector.buttonsPressed[widget.myPlayerNumber][i] ?
                            widget.stateVector.buttonsPressedCorrect[widget.myPlayerNumber][i] ?
                            Colors.greenAccent : Colors.redAccent
                          : Colors.blueAccent,
                          primary: Colors.greenAccent,
                    )
                    )
                    )
                ],
                shrinkWrap: true,
              ),
              //if (showScoreScreen == false)
                               /*QuizComponent(
                    questionText:
                    widget.stateVector.showScoreScreen ? "You got ${widget.stateVector.playerPoints[widget.myPlayerNumber]} points!\n"
                        "Your times: ${widget.stateVector.answerTimes[widget.myPlayerNumber].toString()}ms\n"
                        "Your answers: ${widget.stateVector.answerCorrect[widget.myPlayerNumber].toString()}bool":
                    widget.stateVector.showCountdown ? "Starting in $countdownTime" :
                    widget.quiz.listOfQuestions
                        .elementAt(widget.stateVector.currentQuestion)
                        .questionText,
                    answers:
                    widget.quiz.listOfQuestions.elementAt(currentQuestion).answers.toString(),
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
                  )],
    ),*/
              if (widget.stateVector.showTimeUntilAnswer == true)
                Text("Time elapsed: ${widget.measureTime.elapsed.inMilliseconds.toString()} ms"),
              //Text("Progress indicator: ${(timerProgress * 100)} %"),

             // if (widget.stateVector.showCountdown == false && widget.stateVector.showScoreScreen == false)
                LinearProgressIndicator(
                  value: timerProgress,
                  minHeight: 15,
                ),
              //for debug
              Text(widget.stateVector.toString()),
              //
              Row(
                children: <Widget> [
                  Expanded(
                      child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, '/sharedQuizes'),
                        child: const Text("back"),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          primary: Colors.greenAccent,
                          padding: const EdgeInsets.all(20)),
                      )
                    )
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: widget.stateVector.buttonsActive ? () => next() : null,
                          child: const Text("next"),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            primary: Colors.greenAccent,
                            padding: const EdgeInsets.all(20)),
                          ),
                    )
                  )
                ]
              )

              //Text("Time elapsed: $currentTime")
            ]),
      ),
    );
  }
}

