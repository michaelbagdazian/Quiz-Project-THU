class Question {
  int id;
  String questionText;
  List<String> answers;
  int correctAnswer;

  Question({this.id, this.questionText, this.answers, this.correctAnswer});

  bool isAnswerCorrect(int number) {
    if (number == correctAnswer) {
      return true;
    } else {
      return false;
    }
  }
}
