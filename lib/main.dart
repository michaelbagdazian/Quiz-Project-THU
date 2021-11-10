import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/classes/game.dart';
import 'package:flutter_complete_guide/classes/question.dart';
import 'package:flutter_complete_guide/classes/quiz.dart';

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
  listOfIdsQuestions: [
    testQuestion1,
    testQuestion2,
    testQuestion3,
    testQuestion4
  ],
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
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  void answer(int number) {
    testGame.lastButtonPressed = number;
    if (number ==
        testQuiz.listOfIdsQuestions[testGame.currentQuestion].correctAnswer) {
      testGame.lastAnswerCorrect = true;
    } else {
      testGame.lastAnswerCorrect = false;
    }
    setState(() {
      testGame.currentQuestion++;
    });
    if (testGame.currentQuestion > 3) {
      testGame.currentQuestion = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(testQuiz.getTitleOfQuiz()),
        ),
        body: Column(
          children: [
            Text(testQuiz
                .listOfIdsQuestions[testGame.currentQuestion].questionText),
            ElevatedButton(
              onPressed: () => answer(0),
              child: Text(testQuiz
                  .listOfIdsQuestions[testGame.currentQuestion].answers[0]),
            ),
            ElevatedButton(
              onPressed: () => answer(1),
              child: Text(testQuiz
                  .listOfIdsQuestions[testGame.currentQuestion].answers[1]),
            ),
            ElevatedButton(
              onPressed: () => answer(2),
              child: Text(testQuiz
                  .listOfIdsQuestions[testGame.currentQuestion].answers[2]),
            ),
            ElevatedButton(
              onPressed: () => answer(3),
              child: Text(testQuiz
                  .listOfIdsQuestions[testGame.currentQuestion].answers[3]),
            ),
            Text("DEBUG"),
            Text("Right answer: " +
                testQuiz
                    .listOfIdsQuestions[testGame.currentQuestion].correctAnswer
                    .toString()),
            Text("Last Button pressed: " +
                testGame.lastButtonPressed.toString()),
            Text("Yout last answer was : " +
                testGame.lastAnswerCorrect.toString())
          ],
        ),
      ),
    );
  }
}
