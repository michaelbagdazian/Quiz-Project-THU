import '../models/question.dart';

class Quiz {
  int id;
  String titleOfQuiz;
  int creatorId;
  List<Question> listOfQuestions;
  List<String> tags;

  Quiz(
      {this.id,
      this.titleOfQuiz,
      this.creatorId,
      this.listOfQuestions,
      this.tags});

  int getNumberOfQuestions(int id) {
    return listOfQuestions.length;
  }

  String getTitleOfQuiz() {
    return titleOfQuiz;
  }
}
