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
      {this.id,
      this.playerId,
      this.quizId,
      this.currentQuestion,
      this.points,
      this.time,
      this.lastButtonPressed,
      this.lastAnswerCorrect});
}
