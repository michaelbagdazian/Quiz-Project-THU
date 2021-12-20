import 'package:crew_brew/models/quiz/game_state.dart';

import 'package:crew_brew/models/quiz/Quiz.dart';

class QuizState {
  Quiz quiz;
  GameState stateVector;

  QuizState({
    required this.quiz,
    required this.stateVector,
  });
}
