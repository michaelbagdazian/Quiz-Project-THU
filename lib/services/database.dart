import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/models/user/UserData.dart';
import 'package:flutter/material.dart';

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

  // ! updateQuizData
  // ~ Here we update quizData in DB
  // ~ We call this function when user creates the quiz on Home page
  // ~ it's return value is Future, because it's async function
  Future updateQuizData(String quizCategory, String quizTitle, String quizOwner,
      String quizDescription, bool quizIsShared) async {
    // ~ If document does not exist yet, then Firebase will create the document for us.
    // ~ We pass the data through map (key-value pairs) to set method
    return await quizCollection.doc().set({
      'quizCategory': quizCategory,
      'quizTitle': quizTitle,
      'quizOwner': quizOwner,
      'quizOwnerUID': uid,
      'quizDescription': quizDescription,
      'quizIsShared': quizIsShared,
    });
  }

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

  // ! Stream<List<Quiz>> for shared quizes
  // ~ Here we define the stream for the changes in shared quizes and then screens/quizes/sharedQuizes will provide the stream to children
  Stream<List<Quiz>> get sharedQuizes {
    // ~ Here snapshot is taken from all entries
    return quizCollection.snapshots().map(_sharedQuizListFromSnapshot);
  }

  // * Difference between QuerySnapshot and DocumentSnapshot https://firebase.flutter.dev/docs/firestore/usage/

  // ! _sharedQuizListFromSnapshot
  // ~ This returns list of shared quizes from snapshot in DB. This method is used by shredQuizes stream above.
  List<Quiz> _sharedQuizListFromSnapshot(QuerySnapshot snapshot) {
    List<Quiz> sharedQuizList = [];

    snapshot.docs.forEach((doc) {
      bool quizIsShared = doc.get('quizIsShared');
      if (quizIsShared) {
        sharedQuizList.add(quizListFromSnapshot(doc, quizIsShared));
      }
    });

    return sharedQuizList;
  }

  // ! Stream<List<Quiz>> for shared quizes
  // ~ Here we define the stream for the changes in my quizes and then screens/quizes/myQuizes will provide the stream to children
  Stream<List<Quiz>> get myQuizes {
    return quizCollection.snapshots().map(_myQuizListFromSnapshot);
  }

  // ! _myQuizListFromSnapshot
  // ~ This returns list of myQuizes from snapshot in DB. This method is used by myQuizes stream above.
  List<Quiz> _myQuizListFromSnapshot(QuerySnapshot snapshot) {
    List<Quiz> sharedQuizList = [];

    snapshot.docs.forEach((doc) {
      String quizOwnedUID = doc.get('quizOwnerUID');
      if (quizOwnedUID == uid) {
        sharedQuizList.add(quizListFromSnapshot(doc, doc.get('quizIsShared')));
      }
    });

    return sharedQuizList;
  }

  // ! quizListFromSnapshot
  // ~ This is helped merhoD. It returns single quiz instance from one document. Used by _myQuizListFromSnapshot and _sharedQuizListFromSnapshot
  Quiz quizListFromSnapshot(DocumentSnapshot doc, bool quizIsShared) {
    return Quiz(
        quizCategory: doc.get('quizCategory'),
        quizTitle: doc.get('quizTitle'),
        quizOwner: doc.get('quizOwner'),
        quizOwnerUID: doc.get('quizOwnerUID'),
        quizDescription: doc.get('quizDescription'),
        quizIsShared: quizIsShared);
  }

  // ! Stream<UserData>
  // ~ Here we define the stream for the changes to User Data and then it is used by StreamBuilders in classes such as NavBar, myProfile, home
  Stream<UserData>? get userData {
    // ~ Here snapshot is taken ONLY from what user with this UID should see ( only his userData )
    Stream<UserData> stream =
        userDataCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
    // ~ We convert out stream to boardCastStream, so that multiple classes can be listeners ( by default it's one listener ). Necessary when using StreamBuilder and not StreamProvider
    return stream.asBroadcastStream();
  }

  // _userDataFromSnapshot
  // ~ Here we convert DocumentSnapshot into our custom defined UserData object
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot['username'],
      email: snapshot['email'],
      avatar: snapshot['avatar'],
      level: snapshot['level'],
    );
  }
}
