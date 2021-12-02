import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/question.dart';
import 'package:crew_brew/models/user/UserData.dart';

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

  // * ==================================================
  // * QUIZES SECTION START
  // * ==================================================

  // ! updateQuizData
  // ~ Here we update quizData in DB
  // ~ We call this function when user creates the quiz on Home page
  // ~ it's return value is Future, because it's async function
  Future updateQuizData(Quiz quiz) async {
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
    });
  }

  // ! _convertQuestionsToMap
  // ~ This is a helper class for updateNewQuizData
  // ~ This is a private class, which converts List<Question> to Map<String, Map<String, bool>>, since Flutter only has default data types
  Map<String, Map<String, bool>> _convertQuestionsToMap(
      List<Question> questions) {
    Map<String, Map<String, bool>> mapOfQuestions =
        new Map<String, Map<String, bool>>();

    for (Question question in questions) {
      String questionText = question.questionText;
      List<String> answers = question.answers;
      int correctAnswer = question.correctAnswer;

      Map<String, bool> answersMap = new Map<String, bool>();
      for (int i = 0; i < answers.length; i++) {
        answersMap[answers[i]] = (i == correctAnswer);
      }

      mapOfQuestions[questionText] = answersMap;
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
        listOfQuestions: listOfQuestions,
        tags: List.from(doc.get('tags')));
  }

  // ! _questionObjectFromMap
  // ~ This is a helper function used by newQuizFromSnapshot
  // ~ this returns Question object from the map.
  Question _questionObjectFromMap(String key, Map<String, bool> value) {
    Map<String, bool> answers = value;
    String questionText = key;
    int correctAnswer = -1;

    int index = 0;
    List<String> answersList = [];
    answers.forEach((key, value) {
      answersList.add(key);
      if (value == true) {
        correctAnswer = index;
      }

      index++;
    });

    return new Question(
        questionText: questionText,
        answers: answersList,
        correctAnswer: correctAnswer);
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
      String username, String email, String avatar, int level) async {
    // ~ Get the document based on the UID of the user
    // ~ If document does not exist yet, then Firebase will create the document with that UID. If it does exist, it will update information using uid
    // ~ We pass the data through map (key-value pairs) to set method
    return await userDataCollection.doc(uid).set({
      'username': username,
      'email': email,
      'avatar': avatar,
      'level': level,
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

  // ! _userDataFromSnapshot
  // ~ Here we convert DocumentSnapshot into our custom defined UserData object
  UserData userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot['username'],
      email: snapshot['email'],
      avatar: snapshot['avatar'],
      level: snapshot['level'],
    );
  }

  // ! deleteUserData()
  // ~ This deletes userData based on UID
  Future<void> deleteUserData() {
    return userDataCollection.doc(uid).delete();
  }

  // * ==================================================
  // * USER SECTION END
  // * ==================================================

}
