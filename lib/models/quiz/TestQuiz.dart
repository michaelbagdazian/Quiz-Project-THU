import 'package:crew_brew/models/quiz/question.dart';

class TestQuiz{

  String titleOfQuiz;
  String creatorId;
  List<Question> listOfQuestions;
  List<String> tags;

  TestQuiz(
      {required this.titleOfQuiz,
        required this.creatorId,
        required this.listOfQuestions,
        required this.tags});

}