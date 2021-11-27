import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/question.dart';

// ! Information about the class:
// ~ This class is used for testing purposes. It will return the instance of a quiz, containing all necessary information and structure.

class ManualQuizeCreation {
  Quiz createTestQuiz(String quizOwnerUID, String quizOwner,
      bool quizIsShared) {
    // ! Question #1
    // ~ questionText
    String questionText_1 = "What is the capital of Assyria?";

    // ~ Answers to Question #1
    List<String> answers_1 = [];
    answers_1.add("Nineveh");
    answers_1.add("I don't know that! Auuuuuuuugh!");
    answers_1.add("Babylon");
    answers_1.add("Assur");

    // ~ Correct answer to Question #1
    int correctAnswer_1 = 3;

    // ~ Question #1 instance
    Question question_1 = _createQuestion(
        questionText_1, answers_1, correctAnswer_1);

    // ! Question #2
    // ~ questionText
    String questionText_2 = "What is the air-speed velocity of an unladen swallow?";

    // ~ Answers to Question #2
    List<String> answers_2 = [];
    answers_2.add("An African or European swallow?");
    answers_2.add("about 15 km/h");
    answers_2.add("172 cms per minute");
    answers_2.add("I don't know that!");

    // ~ Correct answer to Question #2
    int correctAnswer_2 = 0;

    // ~ Question #2 instance
    Question question_2 = _createQuestion(
        questionText_2, answers_2, correctAnswer_2);

    // ! Question #3
    // ~ questionText
    String questionText_3 = "What is your name?";

    // ~ Answers to Question #3
    List<String> answers_3 = [];
    answers_3.add("Donald Trump");
    answers_3.add("Sir Lancelot of Camelot");
    answers_3.add("Mickey Mouse");
    answers_3.add("Marylin Monroe");

    // ~ Correct answer to Question #3
    int correctAnswer_3 = 1;

    // ~ Question #3 instance
    Question question_3 = _createQuestion(
        questionText_3, answers_3, correctAnswer_3);

    // ! Question #4
    // ~ questionText
    String questionText_4 = "What is your favorite color";

    // ~ Answers to Question #4
    List<String> answers_4 = [];
    answers_4.add("Magenta");
    answers_4.add("Olive");
    answers_4.add("Blue");
    answers_4.add("Blue, no yellow");

    // ~ Correct answer to Question #4
    int correctAnswer_4 = 2;

    // ~ Question #4 instance
    Question question_4 = _createQuestion(
        questionText_4, answers_4, correctAnswer_4);

    // ! Question #5
    // ~ questionText
    String questionText_5 = "What is your Quest?";

    // ~ Answers to Question #5
    List<String> answers_5 = [];
    answers_5.add("To wash the dishes");
    answers_5.add("To do my taxes");
    answers_5.add("To study flutter");
    answers_5.add("To seek the Holy Grail");

    // ~ Correct answer to Question #5
    int correctAnswer_5 = 3;

    // ~ Question #5 instance
    Question question_5 = _createQuestion(
        questionText_5, answers_5, correctAnswer_5);

    // ! Question list
    List<Question> questionList = [
      question_1,
      question_2,
      question_3,
      question_4,
      question_5
    ];

    // ! Tags list
    List<String> tags = ["funny", "quick"];

    // ! Instance of test quiz
    Quiz testQuiz = _createQuiz(
        "Test",
        "This is test quiz",
        quizOwner,
        quizOwnerUID,
        "This quiz is created for test purposes",
        quizIsShared,
        questionList,
        tags);

    return testQuiz;
  }

  Question _createQuestion(String questionText, List<String> answers,
      int correctAnswer) {
    return new Question(
        questionText: questionText,
        answers: answers,
        correctAnswer: correctAnswer);
  }

  Quiz _createQuiz(String quizCategory,
      String quizTitle,
      String quizOwner,
      String quizOwnerUID,
      String quizDescription,
      bool quizIsShared,
      List<Question> listOfQuestions,
      List<String> tags) {
    return new Quiz(quizCategory: quizCategory,
        quizTitle: quizTitle,
        quizOwner: quizOwner,
        quizOwnerUID: quizOwnerUID,
        quizDescription: quizDescription,
        quizIsShared: quizIsShared,
        listOfQuestions: listOfQuestions,
        tags: tags);
  }
}
