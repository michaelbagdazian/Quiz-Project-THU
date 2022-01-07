import 'dart:async';
import 'package:crew_brew/models/quiz/game_state.dart';
import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/colors.dart';
/// ~ Done by Luke & Holger
/// Declaring class variables, a number for which player it is playing (multiplayer prepared), a game state that handles all the variables that change and some timers. We get the quiz object from the parent class.
/// Class should be immutable, but we did not call it with parameters from a parent widget. Ideally the game state would be initialized there, in some kind of join screen e.g. with multi player. That is why we have to make this a bit messy.
///ignore: must_be_immutable
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

///here we initialize the game state vector in the init state when the widget gets built. ideally this should have been done in parent widget already, so not to have to rely on non final fields and late initialization
///we use a 2D array for the player points, for the times until the answer was given, one for which answers are correct, one for which buttons are currently pressed and one for
///which buttons have been pressed correctly for comparison. Content of pressed buttons get saved into array for result screen. Length of array is determined by maximum player count
///(here 4) and the maximum number of answers for a question in a quiz.
///also timers are started here for the countdown progressbar and the time until answered (for multiplayer who answered first)
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

  ///simple method for getting the maximum number of answers for a question in a quiz
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
    ///spoiler alter: we did not implement that
  }

  ///have variable for the timer progress
  double timerProgress = 1;

  ///next method that handles what happens after a question is answered. Timer is stopped and answer times saved. T
  void next() {
    widget.updateProgress.cancel();
    widget.stateVector.setAnswerTimes(
        widget.myPlayerNumber,
        widget.stateVector.currentQuestion,
        widget.measureTime.elapsed.inMilliseconds);
    ///then arrays for buttons pressed and correct answers are compared
    ///and points added/subtracted accordingly
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
      }
    }
    if (widget.stateVector.playerPoints[widget.myPlayerNumber]
    [widget.stateVector.currentQuestion] <
        0) {
      widget.stateVector.playerPoints[widget.myPlayerNumber]
      [widget.stateVector.currentQuestion] = 0;
    }
    ///saving the pressed buttons into saved pressed button array for result screen
    for (int l = 0; l < widget.quiz.listOfQuestions[widget.stateVector.currentQuestion].answers.length; l++) {
      widget.stateVector.buttonsPressedSaved[widget.myPlayerNumber].add(
          widget.stateVector.buttonsPressed[widget.myPlayerNumber][l]);
    }
    ///updating state to display next question
    setState(() {
      widget.stateVector.buttonsActive = false;
      widget.stateVector.showTimeUntilAnswer = true;
      widget.stateVector.buttonsPressedCorrect;
      widget.stateVector.buttonsPressedSaved;
    });

    ///reset timers then wait for 3 seconds
    Timer(const Duration(seconds: 3), () {
      widget.measureTime.reset();
      timerProgress = 1;
      ///check if end of quiz has been reached
      if (widget.stateVector.currentQuestion ==
          widget.quiz.listOfQuestions.length - 1) {
        ///if so, route to result.dart with stateVector as argument
        QuizState results =
        QuizState(quiz: widget.quiz, stateVector: widget.stateVector);
        Navigator.pushNamed(context, '/results', arguments: results);
      ///or else next round, increment active question, reset corresponding arrays, make buttons active again
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
  ///method to start timer, basically every 1 second the timer gets decremented by 1/countdowntime. This is how time for a question can be adjusted.
  startTimer() {
    widget.updateProgress = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        timerProgress = timerProgress - 1 / widget.countdownTime;
        ///set the state to display it with LinearProgressIndicator
        setState(() {
          timerProgress;
        });
        ///if time runs out, stop and reset timer and treat it as nothing answered and proceed to next()
        if (timerProgress <= 0) {
          widget.updateProgress.cancel();
          widget.stateVector.setAnswerCorrect(
              widget.myPlayerNumber, widget.stateVector.currentQuestion, false);
          timerProgress = 1;
          next();
        }
      },
    );
  }
  ///override method to dispose of periodic timer (for LinearProgressIndicator) after widget is closed. Otherwise it runs indefinitely.
  @override
  void dispose() {
    super.dispose();
    widget.updateProgress.cancel();
  }

  ///method for clicking a button as answer, basically just switches isPressed on and off with a click
  void answer(int number) {
    setState(() {
      widget.stateVector.buttonsPressed[widget.myPlayerNumber][number] =
      !(widget.stateVector.buttonsPressed[widget.myPlayerNumber][number]);
      widget.stateVector = widget.stateVector;
    });
  }

  ///the widget that is returned
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
                ///make a button for each answer of question with text of answer on it.
                ///display them in different colors depending on if they have been pressed (yellow), correct (green) or incorrect (red).
                ///this is handled via booleans.
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

                ///the two buttons for back and next
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