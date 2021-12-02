class Question {
  String questionText;
  List<String> answers;
  late int correctAnswer;
  // late List<int> correctAnswers = <int>[];

  Question({
    required this.questionText,
    required this.answers,
    required this.correctAnswer,
    //required this.correctAnswers,
  });

  bool isAnswerCorrect(int number) {
    if (correctAnswer == number) {
      return true;
    } else {
      return false;
    }
  }
}
