import 'package:flutter/material.dart';
import './widgets/questionBox.dart';
import './models/game.dart';
import './models/question.dart';
import './models/quiz.dart';

final testQuestion1 = Question(
  id: 1,
  questionText: "What is your name?",
  answers: [
    "Donald Trump",
    "Sir Lancelot of Camelot",
    "Mickey Mouse",
    "Marylin Monroe"
  ],
  correctAnswer: 1,
);
final testQuestion2 = Question(
  id: 2,
  questionText: "What is your Quest",
  answers: [
    "To wash the dishes",
    "To do my taxes",
    "To study flutter",
    "To seek the Holy Grail"
  ],
  correctAnswer: 3,
);
final testQuestion3 = Question(
  id: 3,
  questionText: "What is your favorite color",
  answers: ["Magenta", "Olive", "Blue", "Blue, no yellow"],
  correctAnswer: 2,
);
final testQuestion4 = Question(
  id: 4,
  questionText: "What is the airspeed velocity of an unladen swallow?",
  answers: [
    "African of European?",
    "about 15 km/h",
    "172 cms per minute",
    "I don't know that!"
  ],
  correctAnswer: 0,
);
final testQuiz = Quiz(
  id: 1,
  titleOfQuiz: "The Bridge",
  creatorId: 1,
  listOfQuestions: [testQuestion1, testQuestion2, testQuestion3, testQuestion4],
  tags: ["monty", "python"],
);
final testGame = Game(
  id: 1,
  playerId: 1,
  quizId: 1,
  currentQuestion: 0,
  points: 0,
  time: 0,
  lastButtonPressed: 0,
  lastAnswerCorrect: false,
);
void main() {
  runApp(TheQuizzler());
}

class TheQuizzler extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TheQuizzlerState();
  }
}

class TheQuizzlerState extends State<TheQuizzler> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(testQuiz.getTitleOfQuiz()),
        ),
        body: QuestionBox(
          testGame: testGame,
          testQuiz: testQuiz,
          testQuestion1: testQuestion1,
          testQuestion2: testQuestion2,
          testQuestion3: testQuestion3,
          testQuestion4: testQuestion4,
        ),
      ),
    );
  }
}
