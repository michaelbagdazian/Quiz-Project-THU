class Question {
  String questionText;
  List<String> answers;
  int correctAnswer;

  Question({required this.questionText, required this.answers, required this.correctAnswer});

  bool isAnswerCorrect(int number) {
    if (number == correctAnswer) {
      return true;
    } else {
      return false;
    }
  }
}
