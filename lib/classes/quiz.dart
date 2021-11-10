import 'package:flutter_complete_guide/classes/question.dart';

class Quiz {
  int id;
  String titleOfQuiz;
  int creatorId;
  List<Question> listOfIdsQuestions;
  List<String> tags;

  Quiz(
      {this.id,
      this.titleOfQuiz,
      this.creatorId,
      this.listOfIdsQuestions,
      this.tags});

  int getNumberOfQuestions(int id) {
    return listOfIdsQuestions.length;
  }

  String getTitleOfQuiz() {
    return titleOfQuiz;
  }
}
