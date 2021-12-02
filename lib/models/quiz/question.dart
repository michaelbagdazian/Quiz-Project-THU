class Question {
  String questionText;
  List<String> answers;
  int correctAnswer;

  Question({
    required this.questionText,
    required this.answers,
    required this.correctAnswer,
  });

  bool isAnswerCorrect(int number) {
    if (correctAnswer == number) {
      return true;
    } else {
      return false;
    }
  }
}
