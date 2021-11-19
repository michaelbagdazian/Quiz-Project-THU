class Game {
  int id;
  int playerId;
  int quizId;
  int currentQuestion;
  int points;
  int time;
  int lastButtonPressed;
  bool lastAnswerCorrect;

  Game(
      {required this.id,
      required this.playerId,
      required this.quizId,
      required this.currentQuestion,
      required this.points,
      required this.time,
      required this.lastButtonPressed,
      required this.lastAnswerCorrect});
}
