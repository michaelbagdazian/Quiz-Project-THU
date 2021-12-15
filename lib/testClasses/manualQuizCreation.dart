import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/question.dart';

import '../models/quiz/answer.dart';

// ! Information about the class:
// ~ This class is used for testing purposes. It will return the instance of a quiz, containing all necessary information and structure.

class ManualQuizeCreation {
  Quiz createTestQuiz(
      String quizOwnerUID, String quizOwner, bool quizIsShared) {
    // ! Question #1
    // ~ questionText
    String questionText_1 = "What is the capital of Assyria?";

    // ~ Answers to Question #1
    List<Answer> answers_1 = [];
    answers_1.add(new Answer(answerText: "Nineveh", isCorrect: false));
    answers_1.add(new Answer(answerText: "I don't know that! Auuuuuuuugh!", isCorrect: false));
    answers_1.add(new Answer(answerText: "Babylon ( true )", isCorrect: true));
    answers_1.add(new Answer(answerText: "Roshan ( true )", isCorrect: true));

    // ~ Question #1 instance
    Question question_1 = _createQuestion(questionText_1, answers_1);

    // ! Question #2
    // ~ questionText
    String questionText_2 =
        "What is the air-speed velocity of an unladen swallow?";

    // ~ Answers to Question #2
    List<Answer> answers_2 = [];
    answers_2.add(new Answer(answerText: "An African or European swallow?", isCorrect: false));
    answers_2.add(new Answer(answerText: "about 15 km/h ( true )", isCorrect: true));
    answers_2.add(new Answer(answerText: "172 cms per minute", isCorrect: false));
    answers_2.add(new Answer(answerText: "I don't know that!", isCorrect: false));

    // ~ Question #2 instance
    Question question_2 = _createQuestion(questionText_2, answers_2);

    // ! Question #3
    // ~ questionText
    String questionText_3 = "What is your name?";

    // ~ Answers to Question #3
    List<Answer> answers_3 = [];
    answers_3.add(new Answer(answerText: "Donald Trump", isCorrect: false));
    answers_3.add(new Answer(answerText: "Sir Lancelot of Camelot ( true )", isCorrect: true));
    answers_3.add(new Answer(answerText: "Mickey Mouse ( true )", isCorrect: true));
    answers_3.add(new Answer(answerText: "Marylin Monroe", isCorrect: false));

    // ~ Question #3 instance
    Question question_3 = _createQuestion(questionText_3, answers_3);

    // ! Question #4
    // ~ questionText
    String questionText_4 = "What is your favorite color";

    // ~ Answers to Question #4
    List<Answer> answers_4 = [];
    answers_4.add(new Answer(answerText: "Magenta ( true )", isCorrect: true));
    answers_4.add(new Answer(answerText: "Olive", isCorrect: false));
    answers_4.add(new Answer(answerText: "Blue", isCorrect: false));
    answers_4.add(new Answer(answerText: "Blue, no yellow", isCorrect: false));

    // ~ Question #4 instance
    Question question_4 = _createQuestion(questionText_4, answers_4);

    // ! Question #5
    // ~ questionText
    String questionText_5 = "What is your Quest?";

    // ~ Answers to Question #5
    List<Answer> answers_5 = [];
    answers_5.add(new Answer(answerText: "To wash the dishes", isCorrect: false));
    answers_5.add(new Answer(answerText: "To do my taxes", isCorrect: false));
    answers_5.add(new Answer(answerText: "To study flutter", isCorrect: false));
    answers_5.add(new Answer(answerText: "To seek the Holy Grail ( true )", isCorrect: true));

    // ~ Question #5 instance
    Question question_5 = _createQuestion(questionText_5, answers_5);

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

  Question _createQuestion(String questionText, List<Answer> answers) {
    return Question(questionText: questionText, answers: answers);
  }

  Quiz _createQuiz(
      String quizCategory,
      String quizTitle,
      String quizOwner,
      String quizOwnerUID,
      String quizDescription,
      bool quizIsShared,
      List<Question> listOfQuestions,
      List<String> tags) {
    return Quiz(
        quizCategory: quizCategory,
        quizTitle: quizTitle,
        quizOwner: quizOwner,
        quizOwnerUID: quizOwnerUID,
        quizDescription: quizDescription,
        quizIsShared: quizIsShared,
        quizID: '',
        listOfQuestions: listOfQuestions,
        tags: tags);
  }
}
