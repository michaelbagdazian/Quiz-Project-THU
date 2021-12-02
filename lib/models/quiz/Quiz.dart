// ignore_for_file: file_names

import 'package:crew_brew/models/quiz/question.dart';

// ! Information about the class:
// ~ This class represent an entry collection in the Firestore DB called 'quizes'. The entry in the Firestore DB is created after the user creates a new Quiz
// ~ By registration a default Quiz is created, then can be added with " create public/private Quiz "
// ! Use of the class:
// ~ It is used in services/database.dart in the method _my/sharedQuizListFromSnapshot, where we convert QuerySnapshot to the instance Quiz
// ~ and then make use of it in the defined Stream<Quiz> for private quizes and shared quizes

// ! TODOS:
// all done

class Quiz {
  String quizCategory;
  String quizTitle;
  String quizOwner;
  String quizOwnerUID;
  String quizDescription;
  bool quizIsShared;
  String quizID;
  List<Question> listOfQuestions;
  List<String> tags;

  Quiz(
      {required this.quizCategory,
        required this.quizTitle,
        required this.quizOwner,
        required this.quizOwnerUID,
        required this.quizDescription,
        required this.quizIsShared,
        required this.quizID,
        required this.listOfQuestions,
        required this.tags});

  int getNumberOfQuestions(int id) {
    return listOfQuestions.length;
  }

  String getTitleOfQuiz() {
    return quizTitle;
  }
}
