import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/question.dart';
import 'package:crew_brew/models/user/UserData.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/game/game.dart';
import '../models/quiz/answer.dart';

// ! Information about the class:
// ~ This class is a service class for database manipulations
// ! Use of the class:
// ~ Here we define all methods that are going to interact Firestore DB

// ! TODOS:
// TODO For now updateQuizData can only create a quiz. Extend this method so that it allows to change the quiz

class DatabaseService {
  // ~ Whenever using the DatabaseService, we should provide UID. It can also be empty ( e.g when accesing shared quizes )
  final String uid;

  DatabaseService({required this.uid});

  // ! Quizes collection reference ( a reference to a particular collection on our firestore database )
  // ~ Here we define reference to collection of quizes in DB
  // ~ when we want to read or write from/into that collection, we will use this reference
  // ~ If by the time this line is executed and 'quizes' collection does not exist in Firebase, it will create it for us
  final CollectionReference quizCollection =
      FirebaseFirestore.instance.collection('quizes');

  // ! UserData collection reference ( a reference to a particular collection on our firestore database )
  // ~ Here we define reference to collection of user data in DB
  // ~ when we want to read or write from/into that collection, we will use this reference
  // ~ If by the time this line is executed and 'user_data' collection does not exist in Firebase, it will create it for us
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('user_data');

  // ! Game collection reference ( a reference to a particular collection on our firestore database )
  // ~ Here we define reference to collection of user data in DB
  // ~ when we want to read or write from/into that collection, we will use this reference
  // ~ If by the time this line is executed and 'game' collection does not exist in Firebase, it will create it for us
  final CollectionReference gameCollection =
      FirebaseFirestore.instance.collection('game');

  // * ==================================================
  // * QUIZES SECTION START
  // * ==================================================

  // ! createQuizData
  // ~ Here we create quiz in DB
  // ~ We call this function when user creates the quiz on Home page
  // ~ it's return value is Future, because it's async function
  Future createQuizData(Quiz quiz) async {
    Map<String, Map<String, bool>> mapOfQuestions =
        _convertQuestionsToMap(quiz.listOfQuestions);

    return await quizCollection.doc().set({
      'quizCategory': quiz.quizCategory,
      'quizTitle': quiz.quizTitle,
      'quizOwner': quiz.quizOwner,
      'quizOwnerUID': uid,
      'quizDescription': quiz.quizDescription,
      'quizIsShared': quiz.quizIsShared,
      'listOfQuestions': mapOfQuestions,
      'tags': quiz.tags,
      'timeStamp': DateTime.now()
    });
  }

  // ! updateQuizData
  // ~ Here we update quiz in DB
  Future updateQuizData(Quiz quiz) async {
    Map<String, Map<String, bool>> mapOfQuestions =
        _convertQuestionsToMap(quiz.listOfQuestions);

    return await quizCollection.doc(quiz.quizID).set({
      'quizCategory': quiz.quizCategory,
      'quizTitle': quiz.quizTitle,
      'quizOwner': quiz.quizOwner,
      'quizOwnerUID': uid,
      'quizDescription': quiz.quizDescription,
      'quizIsShared': quiz.quizIsShared,
      'listOfQuestions': mapOfQuestions,
      'tags': quiz.tags,
      'timeStamp': DateTime.now()
    });
  }

  // ! _convertQuestionsToMap
  // ~ This is a helper class for updateNewQuizData
  // ~ This is a private class, which converts List<Question> to Map<String, Map<String, bool>>, since Flutter only has default data types
  Map<String, Map<String, bool>> _convertQuestionsToMap(
      List<Question> questions) {
    Map<String, Map<String, bool>> mapOfQuestions =
        Map<String, Map<String, bool>>();

    for (Question question in questions) {
      String questionText = question.questionText;
      Map<String, bool> answers = Map<String, bool>();

      for (Answer answer in question.answers) {
        answers[answer.answerText] = answer.isCorrect;
      }

      mapOfQuestions[questionText] = answers;
    }

    return mapOfQuestions;
  }

  // ! Stream<List<Quiz>> for shared quizes
  // ~ Here we define the stream for the changes in my quizes and then screens/quizes/myQuizes will provide the stream to children
  Stream<List<Quiz>> get myQuizes {
    return quizCollection.snapshots().map(_myQuizListFromSnapshot);
  }

  List<Quiz> _myQuizListFromSnapshot(QuerySnapshot snapshot) {
    List<Quiz> myQuizList = [];

    snapshot.docs.forEach((doc) {
      String quizOwnedUID = doc.get('quizOwnerUID');
      if (quizOwnedUID == uid) {
        myQuizList.add(_quizFromSnapshot(doc, doc.get('quizIsShared')));
      }
    });

    return myQuizList;
  }

  // ! Stream<List<Quiz>> for shared quizes
  // ~ Here we define the stream for the changes in shared quizes and then screens/quizes/sharedQuizes will provide the stream to children
  Stream<List<Quiz>> get sharedQuizes {
    // ~ Here snapshot is taken from all entries
    return quizCollection.snapshots().map(_sharedQuizListFromSnapshot);
  }

  // ! _sharedQuizListFromSnapshot
  // ~ This returns list of shared quizes from snapshot in DB. This method is used by shredQuizes stream above.
  List<Quiz> _sharedQuizListFromSnapshot(QuerySnapshot snapshot) {
    List<Quiz> sharedQuizList = [];

    snapshot.docs.forEach((doc) {
      bool quizIsShared = doc.get('quizIsShared');
      if (quizIsShared) {
        sharedQuizList.add(_quizFromSnapshot(doc, quizIsShared));
      }
    });

    return sharedQuizList;
  }

  // ! quizFromSnapshot
  // ~ This is helper method. It returns single quiz instance from one document. Used by _myQuizListFromSnapshot and _sharedQuizListFromSnapshot
  Quiz _quizFromSnapshot(DocumentSnapshot doc, bool quizIsShared) {
    // ~ Here we perform some type transformation, so the type of our map is the same as we have uploaded it
    // ~ I know is pretty cryptic, but cannot do anything about it
    Map<String, Map<String, dynamic>> dynamicMap =
        Map.from(doc.get('listOfQuestions')).map((key, value) =>
            MapEntry(key as String, value as Map<String, dynamic>));
    Map<String, Map<String, bool>> mapOfQuestions = dynamicMap.map((key,
            value) =>
        MapEntry(key, value.map((key, value) => MapEntry(key, value as bool))));

    List<Question> listOfQuestions = [];

    mapOfQuestions.forEach((key, value) {
      Question question = _questionObjectFromMap(key, value);

      listOfQuestions.add(question);
    });

    return Quiz(
        quizCategory: doc.get('quizCategory'),
        quizTitle: doc.get('quizTitle'),
        quizOwner: doc.get('quizOwner'),
        quizOwnerUID: doc.get('quizOwnerUID'),
        quizDescription: doc.get('quizDescription'),
        quizIsShared: doc.get('quizIsShared'),
        quizID: doc.id,
        listOfQuestions: listOfQuestions,
        tags: List.from(doc.get('tags')));
  }

  // ! _questionObjectFromMap
  // ~ This is a helper function used by newQuizFromSnapshot
  // ~ this returns Question object from the map.
  Question _questionObjectFromMap(
      String questionText, Map<String, bool> answers) {
    List<Answer> answersList = [];
    answers.forEach((key, value) {
      answersList.add(Answer(answerText: key, isCorrect: value));
    });

    return Question(questionText: questionText, answers: answersList);
  }

  // ! deleteQuiz()
  // ~ This deletes all the quizes for one user
  // ~ We are using batch to perform the request. Submitting request as batch means that we send one single request from the client side
  // ~ so deleting 10 quizes is one request from the client, the rest is handled by the server
  // ~ it allows client now to wait while delete is performed
  Future<void> deleteAllQuizesPerUID() {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    return quizCollection
        .where('quizOwnerUID', isEqualTo: uid)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });

      return batch.commit();
    });
  }

  // * ==================================================
  // * QUIZES SECTION END
  // * ==================================================

  // * ==================================================
  // * USER SECTION START
  // * ==================================================
  // ! updateUserData
  // ~ Here we update userData in DB
  // ~ We call this function when user is registered or we want to update some information for the user
  // ~ it's return value is Future, because it's async function
  Future updateUserData(
      String username, String email, String avatar, int points) async {
    // ~ Get the document based on the UID of the user
    // ~ If document does not exist yet, then Firebase will create the document with that UID. If it does exist, it will update information using uid
    // ~ We pass the data through map (key-value pairs) to set method
    return await userDataCollection.doc(uid).set({
      'username': username,
      'email': email,
      'avatars': avatar,
      'points': points,
    });
  }

  // ! Stream<UserData>
  // ~ Here we define the stream for the changes to User Data and then it is used by StreamBuilders in classes such as NavBar, myProfile, home
  Stream<UserData>? get userData {
    // ~ Here snapshot is taken ONLY from what user with this UID should see ( only his userData )
    Stream<UserData> stream =
        userDataCollection.doc(uid).snapshots().map(userDataFromSnapshot);
    // ~ We convert out stream to boardCastStream, so that multiple classes can be listeners ( by default it's one listener ). Necessary when using StreamBuilder and not StreamProvider
    return stream.asBroadcastStream();
  }

  // !getUserByID
  // ~ This method was created for Game logic
  Future<UserData> getUserData() {
    return userDataCollection
        .doc(uid)
        .get()
        .then((value) => userDataFromSnapshot(value));
  }

  // ! _userDataFromSnapshot
  // ~ Here we convert DocumentSnapshot into our custom defined UserData object
  UserData userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot['username'],
      email: snapshot['email'],
      avatar: snapshot['avatars'],
      points: snapshot['points'],
    );
  }

  // ! deleteUserData()
  // ~ This deletes userData based on UID
  Future<void> deleteUserData() {
    return userDataCollection.doc(uid).delete();
  }

  // ! changePassword
  // ~ update and validate user password
  // TODO Work on code quality
  Future<bool> changePassword(String currentPassword, String newPassword,
      UserData userData, Function showError) async {
    final user = await FirebaseAuth.instance.currentUser;
    bool isSuccess = true;

    if (user != null) {
      final cred = EmailAuthProvider.credential(
          email: userData.email, password: currentPassword);

      await user.reauthenticateWithCredential(cred).then((value) async {
        await user.updatePassword(newPassword).then((_) {}).catchError((error) {
          showError("Password update failed", error.message);
          isSuccess = false;
        });
      }).catchError((err) {
        showError("Authentication fail", err.message);
        isSuccess = false;
      });
    } else {
      showError("Connection problem", "No internet or user is deleted");
      isSuccess = false;
    }
    return isSuccess;
  }

  // ! changeEmail
  // ~ This method change e-mail in firebase in userData
  // TODO Work on code quality
  Future<bool> changeEmail(String currentPassword, String newEmail,
      UserData userData, Function showError) async {
    final user = await FirebaseAuth.instance.currentUser;
    bool isSuccess = true;

    if (user != null) {
      final cred = EmailAuthProvider.credential(
          email: userData.email, password: currentPassword);

      await user.reauthenticateWithCredential(cred).then((value) async {
        await user.updateEmail(newEmail).then((_) {
          updateUserData(
              userData.username, newEmail, userData.avatar, userData.points);
        }).catchError((error) {
          showError("E-mail update failed", error.message);
          isSuccess = false;
        });
      }).catchError((err) {
        showError("Authentication fail", err.message);
        isSuccess = false;
      });
    } else {
      showError("Connection problem", "No internet or user is deleted");
      isSuccess = false;
    }

    return isSuccess;
  }

// * ==================================================
// * USER SECTION END
// * ==================================================

// * ==================================================
// * GAME SECTION START
// * ==================================================

// ! createGameData
  // ~ Here we create quiz in DB
  // ~ We call this function when user creates the quiz on Home page
  // ~ it's return value is Future, because it's async function
  Future createGameData(Game game) async {
    List<String> participantsIDs = [];

    for (UserData participant in game.participants) {
      participantsIDs.add(participant.uid);
    }

    return await quizCollection.doc().set({
      'gameCreator': game.gameCreator.uid,
      'quiz': game.quiz.quizID,
      'participants': participantsIDs,
      'currentQuestion': game.currentQuestion,
      'points': <String>[],
      'buttonsActive': <String>[],
    });
  }

  // ! Stream<Game> for games
  // ~ Here we define the stream for the changes in shared quizes and then screens/quizes/sharedQuizes will provide the stream to children
  Stream<Game> get game {
    // ~ Here snapshot is taken from all entries
    return gameCollection
        .doc(uid.substring(0, 5))
        .snapshots()
        .map(_gameDataFromSnapshot);
  }

  // ! _gameDataFromSnapshot
  // ~ Here we convert DocumentSnapshot into our custom defined UserData object
  Game _gameDataFromSnapshot(DocumentSnapshot doc) {
    return Game(
        gameID: doc.id,
        gameCreator: doc.get('gameCreator'),
        quiz: doc.get('quiz'),
        participants: doc.get('participants'),
        currentQuestion: doc.get('currentQuestion'),
        points: doc.get('points'),
        buttonsActive: doc.get('buttonsActive'));
  }

// * ==================================================
// * GAME SECTION END
// * ==================================================

}
