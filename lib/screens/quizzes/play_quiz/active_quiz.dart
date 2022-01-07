import 'dart:async';
import 'package:crew_brew/models/quiz/game_state.dart';
import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/colors.dart';
/// ~ Done by Luke & Holger

class ActiveQuiz extends StatefulWidget {
  final Quiz quiz;
  final int myPlayerNumber = 0;
  Stopwatch measureTime = Stopwatch();
  final int countdownTime = 30;
  late Timer updateProgress;
  late GameState stateVector;
  ActiveQuiz({Key? key, required this.quiz}) : super(key: key);

  @override
  _ActiveQuizState createState() => _ActiveQuizState();
}

class _ActiveQuizState extends State<ActiveQuiz> {
  @override
  void initState() {
    widget.stateVector = GameState(
      id: 1,
      players: List.filled(4, 0),
      playerPoints: [List.filled(widget.quiz.listOfQuestions.length, 0)],
      answerTimes: [List.filled(widget.quiz.listOfQuestions.length, 0)],
      answerCorrect: [List.filled(widget.quiz.listOfQuestions.length, false)],
      buttonsPressed: [List.filled(getMaxQuestions(widget.quiz), false)],
      buttonsPressedCorrect: [List.filled(getMaxQuestions(widget.quiz), false)],
      buttonsPressedSaved: [List.empty(growable: true)],
    );
    widget.measureTime.start();
    startTimer();
    super.initState();
  }

  int getMaxQuestions(Quiz quiz) {
    int ret = 0;
    for (int i = 0; i < quiz.listOfQuestions.length; i++) {
      if (quiz.listOfQuestions[i].answers.length > ret) {
        ret = quiz.listOfQuestions[i].answers.length;
      }
    }
    return ret;
  }

  int getMyPlayerNumber() {
    for (int i = 0; i < widget.stateVector.players.length; i++) {
      if (widget.stateVector.players[i] == 0) {
        widget.stateVector.players[i] == 1;
        return i;
      }
    }
    return -1;
    ///TODO: must have a way to handle spectators i.e. players not in list an catch potential errors
  }

  double timerProgress = 1;

  void next() {
    widget.updateProgress.cancel();
    widget.stateVector.setAnswerTimes(
        widget.myPlayerNumber,
        widget.stateVector.currentQuestion,
        widget.measureTime.elapsed.inMilliseconds);

    for (int j = 0; j < 4; j++) {
      if (widget.stateVector.buttonsPressed[widget.myPlayerNumber][j] &&
          widget.quiz.listOfQuestions[widget.stateVector.currentQuestion]
              .answers[j].isCorrect) {
        widget.stateVector.buttonsPressedCorrect[widget.myPlayerNumber][j] =
        true;
        widget.stateVector.playerPoints[widget.myPlayerNumber]
        [widget.stateVector.currentQuestion]++;
      }
      if (widget.stateVector.buttonsPressed[widget.myPlayerNumber][j] &&
          !widget.quiz.listOfQuestions[widget.stateVector.currentQuestion]
              .answers[j].isCorrect) {
        widget.stateVector.playerPoints[widget.myPlayerNumber]
        [widget.stateVector.currentQuestion]--;
        if (widget.stateVector.playerPoints[widget.myPlayerNumber]
        [widget.stateVector.currentQuestion] <
            0) {
          widget.stateVector.playerPoints[widget.myPlayerNumber]
          [widget.stateVector.currentQuestion] = 0;
        }
      }
    }

    for (int l = 0; l < widget.quiz.listOfQuestions[widget.stateVector.currentQuestion].answers.length; l++) {
      widget.stateVector.buttonsPressedSaved[widget.myPlayerNumber].add(
          widget.stateVector.buttonsPressed[widget.myPlayerNumber][l]);
    }

    setState(() {
      widget.stateVector.buttonsActive = false;
      widget.stateVector.showTimeUntilAnswer = true;
      widget.stateVector.buttonsPressedCorrect;
      widget.stateVector.buttonsPressedSaved;
    });

    ///buttonsActive = false;
    ///showTimeToAnswer = true;
    Timer(const Duration(seconds: 3), () {
      widget.measureTime.reset();
      timerProgress = 1;
      if (widget.stateVector.currentQuestion ==
          widget.quiz.listOfQuestions.length - 1) {
        ///route to result.dart with stateVector
        QuizState results =
        QuizState(quiz: widget.quiz, stateVector: widget.stateVector);
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

  startTimer() {
    widget.updateProgress = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        timerProgress = timerProgress - 1 / widget.countdownTime;
        setState(() {
          timerProgress;
        });
        if (timerProgress <= 0) {
          widget.updateProgress.cancel();
          ///answerCorrect.add(0);
          widget.stateVector.setAnswerCorrect(
              widget.myPlayerNumber, widget.stateVector.currentQuestion, false);
          timerProgress = 1;
          next();
        }
      },
    );
  }

  void answer(int number) {
    setState(() {
      widget.stateVector.buttonsPressed[widget.myPlayerNumber][number] =
      !(widget.stateVector.buttonsPressed[widget.myPlayerNumber][number]);
      widget.stateVector = widget.stateVector;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double em = theme.textTheme.bodyText1!.fontSize ?? 16;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bgtop.png'),
                  fit: BoxFit.cover)),
          child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 0.5 * em),
                  child: LinearProgressIndicator(
                    value: timerProgress,
                    minHeight: 0.9 * em,
                    color: theme.primaryColor,
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(
                      left: (theme.textTheme.bodyText2!.fontSize)! * 6,
                      right: (theme.textTheme.bodyText2!.fontSize)! * 6,
                      bottom: (theme.textTheme.bodyText2!.fontSize)! *
                          6), /// ~Equivalent to 4 em's
                  decoration:
                  const BoxDecoration(color: Color.fromARGB(50, 0, 0, 0)),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: em * 2),
                        child: Text(
                          "Question ${widget.stateVector.currentQuestion + 1}/${widget.quiz.listOfQuestions.length}",
                          style: theme.textTheme.headline4!.copyWith(
                            color: texts,
                          ),
                        ),
                      ),
                      Text(
                        widget
                            .quiz
                            .listOfQuestions[widget.stateVector.currentQuestion]
                            .questionText,
                        style: theme.textTheme.headline6!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      for (var i = 0;
                      i <
                          widget
                              .quiz
                              .listOfQuestions[
                          widget.stateVector.currentQuestion]
                              .answers
                              .length;
                      i++)
                        Padding(
                            padding: EdgeInsets.all(.5 * em),
                            child: ElevatedButton(
                                onPressed: widget.stateVector.buttonsActive
                                    ? () => answer(i)
                                    : null,
                                child: Padding(
                                  padding: EdgeInsets.all(2 * em),
                                  child: Text(widget
                                      .quiz
                                      .listOfQuestions[
                                  widget.stateVector.currentQuestion]
                                      .answers[i]
                                      .answerText),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: widget
                                      .stateVector.buttonsActive
                                      ? widget.stateVector.buttonsPressed[
                                  widget.myPlayerNumber][i]
                                      ? Colors.yellowAccent
                                      : theme.primaryColor
                                      : widget.stateVector.buttonsPressed[
                                  widget.myPlayerNumber][i]
                                      ? widget.stateVector
                                      .buttonsPressedCorrect[
                                  widget.myPlayerNumber][i]
                                      ? Colors.greenAccent
                                      : Colors.redAccent
                                      : theme.primaryColor,
                                )))
                    ],
                    shrinkWrap: true,
                  ),
                ),

                ///for debug
                Row(children: <Widget>[
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, '/sharedQuizes'),
                            child: const Text("back"),
                            style: TextButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                padding: const EdgeInsets.all(20)),
                          ))),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: widget.stateVector.buttonsActive
                              ? () => next()
                              : null,
                          child: const Text("next"),
                          style: TextButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              padding: const EdgeInsets.all(20)),
                        ),
                      ))
                ])
              ]),
        ),
      ),
    );
  }
}