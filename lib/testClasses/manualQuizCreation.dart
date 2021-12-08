import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/question.dart';

// ! Information about the class:
// ~ This class is used for testing purposes. It will return the instance of a quiz, containing all necessary information and structure.

class ManualQuizeCreation {
  Quiz createTestQuiz(
      String quizOwnerUID, String quizOwner, bool quizIsShared) {
    // ! Question #1
    // ~ questionText
    String questionText_1 = "What is the capital of Assyria?";

    // ~ Answers to Question #1
    Map<String, bool> answers_1 = Map<String, bool>();
    answers_1["Nineveh"] = false;
    answers_1["I don't know that! Auuuuuuuugh!"] = false;
    answers_1["Babylon ( true )"] = true;
    answers_1["Roshan ( true )"] = true;

    // ~ Question #1 instance
    Question question_1 = _createQuestion(questionText_1, answers_1);

    // ! Question #2
    // ~ questionText
    String questionText_2 =
        "What is the air-speed velocity of an unladen swallow?";

    // ~ Answers to Question #2
    Map<String, bool> answers_2 = Map<String, bool>();
    answers_2["An African or European swallow?"] = false;
    answers_2["about 15 km/h ( true )"] = true;
    answers_2["172 cms per minute"] = false;
    answers_2["I don't know that!"] = false;

    // ~ Question #2 instance
    Question question_2 =
        _createQuestion(questionText_2, answers_2);

    // ! Question #3
    // ~ questionText
    String questionText_3 = "What is your name?";

    // ~ Answers to Question #3
    Map<String, bool> answers_3 = Map<String, bool>();
    answers_3["Donald Trump"] = false;
    answers_3["Sir Lancelot of Camelot ( true )"] = true;
    answers_3["Mickey Mouse ( true )"] = true;
    answers_3["Marylin Monroe"] = false;

    // ~ Question #3 instance
    Question question_3 =
        _createQuestion(questionText_3, answers_3);

    // ! Question #4
    // ~ questionText
    String questionText_4 = "What is your favorite color";

    // ~ Answers to Question #4
    Map<String, bool> answers_4 = Map<String, bool>();
    answers_4["Magenta ( true )"] = true;
    answers_4["Olive"] = false;
    answers_4["Blue"] = false;
    answers_4["Blue, no yellow"] = false;

    // ~ Question #4 instance
    Question question_4 =
        _createQuestion(questionText_4, answers_4);

    // ! Question #5
    // ~ questionText
    String questionText_5 = "What is your Quest?";

    // ~ Answers to Question #5
    Map<String, bool> answers_5 = Map<String, bool>();
    answers_5["To wash the dishes"] = false;
    answers_5["To do my taxes"] = false;
    answers_5["To study flutter"] = false;
    answers_5["To seek the Holy Grail ( true )"] = true;

    // ~ Question #5 instance
    Question question_5 =
        _createQuestion(questionText_5, answers_5);

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

  Question _createQuestion(String questionText, Map<String, bool> answers) {
    return new Question(questionText: questionText, answers: answers);
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
    return new Quiz(
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
