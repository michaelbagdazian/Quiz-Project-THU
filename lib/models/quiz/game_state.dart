import 'package:flutter/cupertino.dart';
import 'dart:convert';


class GameState {
  int id;
  int currentQuestion;
  List<int> players;
  List<List<int>> playerPoints;
  List<List<int>> answerTimes;
  List<List<bool>> answerCorrect;
  List<List<bool>> buttonsPressed;
  List<List<bool>> buttonsPressedCorrect;
  List<List<bool>> buttonsPressedSaved;
  bool showScoreScreen = false;
  bool buttonsActive = true;
  bool showCountdown = true;
  bool showTimeUntilAnswer = false;

  GameState({
    required this.id,
    this.currentQuestion = 0,
    required this.players,
    required this.playerPoints,
    required this.answerTimes,
    required this.answerCorrect,
    required this.buttonsPressed,
    required this.buttonsPressedCorrect,
    required this.buttonsPressedSaved,
    this.showScoreScreen = false,
    this.buttonsActive = true,
    this.showCountdown = true,
    this.showTimeUntilAnswer = false,
    });

  void setPoints(int playerNumber, int questionNumber, int points) {
    playerPoints[playerNumber][questionNumber] += points;
  }
  void setAnswerTimes(int playerNumber, int questionNumber, int time) {
    answerTimes[playerNumber][questionNumber] = time;
  }
  void setAnswerCorrect(int playerNumber, int questionNumber, bool correct) {
    answerCorrect[playerNumber][questionNumber] = correct;
  }
//  GameState.fromJson(Map<dynamic, dynamic> json)
 //     : date = DateTime.parse(json['date'] as String),
   //     text = json['text'] as String;

  Map toJson() {
    /// room for any damned null safety checks
    return {
      'id': id,
      'currentQuestion': currentQuestion,
      'players': jsonEncode(players),
      'playerPoints': jsonEncode(playerPoints),
      'answerTimes': jsonEncode(answerTimes),
      'answerCorrect': jsonEncode(answerCorrect),
      'buttonsPressed': jsonEncode(buttonsPressed),
      'buttonsPressedCorrect': jsonEncode(buttonsPressedCorrect),
      'buttonsPressedSaved': jsonEncode(buttonsPressedSaved),
      'showScoreScreen': showScoreScreen,
      'buttonsActive': buttonsActive,
      'showCountdown': showCountdown,
      'showTimeUntilAnswer': showTimeUntilAnswer
    };
  }
  @override
  String toString() {
    String ret = "Current Question: $currentQuestion, Player Points: ${playerPoints.toString()},"
        "Buttons Pressed: ${buttonsPressed.toString()},"
        "Answer Times: ${answerTimes.toString()},"
        ///"Buttons Correct: ${buttonsPressedCorrect.toString()}"

    ;
    return ret;
  }
}