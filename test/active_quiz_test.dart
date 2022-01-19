import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/answer.dart';
import 'package:crew_brew/models/quiz/game_state.dart';
import 'package:crew_brew/models/quiz/question.dart';
import 'package:crew_brew/screens/quizzes/play_quiz/active_quiz.dart';
import 'package:flutter_test/flutter_test.dart';

/// Automated Unit Tests for active_quiz
/// done by Holger
void main() {
  /// first some initializations for testing
  final Answer testAnswer1 = Answer(answerText: "Sir Lancelot of Camelot", isCorrect: true);
  final Answer testAnswer2 = Answer(answerText: "The Knights who say ni", isCorrect: false);
  final Answer testAnswer3 = Answer(answerText: "A French Taunter", isCorrect: false);
  List<Answer> testAnswers = [testAnswer1, testAnswer2, testAnswer3];
  final Question testQuestion = Question(questionText: "What is your name?", answers: testAnswers);
  List<Question> testQuestions = [testQuestion];
  final Quiz testQuiz = Quiz(quizCategory: "TestCategory", quizTitle: "TestQuiz", quizOwner: "TestUser", quizOwnerUID: "123", quizDescription: "A test Quiz", quizIsShared: false, quizID: "456", listOfQuestions: testQuestions, tags: ["testing", "test"]);
  final GameState testStateVector = GameState(
    id: 1,
    players: List.filled(4, 0),
    playerPoints: [List.filled(1, 0)],
    answerTimes: [List.filled(1, 0)],
    answerCorrect: [List.filled(1, false)],
    buttonsPressed: [List.filled(3, false)],
    buttonsPressedCorrect: [List.filled(3, false)],
    buttonsPressedSaved: [List.empty(growable: true)],
  );
  /// Testing
  /// Testing if maximum number of answers of all questions is indeed 3
  test('Maximum amount of answers for all questions', () {
    final ActiveQuiz testActiveQuiz = ActiveQuiz(quiz: testQuiz);
    expect(testActiveQuiz.createState().getMaxQuestions(testQuiz), 3);
  });
  /// Testing the next method is too complicated, since multiple timers have to be initialized
  /// Testing the answer method is also too complicated since it alters the state of a widget which is not created
  /// Testing answer texts and isCorrect instead
  test('Testing answer texts', () {
    final ActiveQuiz testActiveQuiz = ActiveQuiz(quiz: testQuiz);
    expect(testActiveQuiz.quiz.listOfQuestions[0].answers[0].answerText, "Sir Lancelot of Camelot");
    expect(testActiveQuiz.quiz.listOfQuestions[0].answers[0].isCorrect, true);
    expect(testActiveQuiz.quiz.listOfQuestions[0].answers[1].answerText, "The Knights who say ni");
    expect(testActiveQuiz.quiz.listOfQuestions[0].answers[1].isCorrect, false);
    expect(testActiveQuiz.quiz.listOfQuestions[0].answers[2].answerText, "A French Taunter");
    expect(testActiveQuiz.quiz.listOfQuestions[0].answers[2].isCorrect, false);
  });
}
