import 'package:crew_brew/models/quiz/question.dart';
import 'package:crew_brew/services/database.dart';

import '../user/UserData.dart';
import '../quiz/Quiz.dart';

class Game {
  String gameID; // not changed
  UserData gameCreator;
  Quiz quiz;
  List<UserData> participants;
  int currentQuestion; // will be changed
  List<int> points; // will be changed
  List<bool> buttonsActive; // will be changed

  Game(
      {required this.gameID,
      required this.gameCreator,
      required this.quiz,
      required this.participants,
      required this.currentQuestion,
      required this.points,
      required this.buttonsActive});

  int numberOfParticipants() {
    return participants.length;
  }

  void joinGame(String newParticipant) {
    DatabaseService(uid: newParticipant).getUserData().then((value) {
      participants.add(value);
    });

    // TODO Add new participant to Game DB as UID
  }

  void updateUesrPoints(UserData participant, int points) {
    DatabaseService(uid: participant.uid).updateUserData(participant.username,
        participant.email, participant.avatar, participant.points + points);
  }
}
