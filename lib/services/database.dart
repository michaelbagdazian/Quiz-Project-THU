import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew_brew/models/Quiz.dart';
import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/models/user/UserData.dart';
import 'package:flutter/material.dart';

// ! The instance of DatabaseService is created in the class auth.dart when user is registered
class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // ~ collection reference ( a reference to a particular collection on our firestore database )
  // ~ when we want to read or write from/into that collection, we will use this reference
  // ! If by the time this line is executed and 'brews' collection does not exist in Firebase, it will create it for us
  // * Here we define reference to collection of quizes in DB
  final CollectionReference quizCollection =
      FirebaseFirestore.instance.collection('quizes');

  // ~ collection reference ( a reference to a particular collection on our firestore database )
  // ~ when we want to read or write from/into that collection, we will use this reference
  // ! If by the time this line is executed and 'brews' collection does not exist in Firebase, it will create it for us
  // * Here we define reference to collection of user data in DB
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('user_data');

  // ~ it's return value is Future, because it's async function
  // ! We call this function when user registers in auth.dart ( for now )
  // * Here we update quizData in DB
  Future updateQuizData(String quizCategory, String quizTitle, String quizOwner,
      String quizDescription, bool quizIsShared) async {
    // ~ Get the document based on the UID of the user
    // ~ If document does not exist yet, then Firebase will create the document with that UID. Thereby linking the Firestore document for that user with the Firebase User
    // ~ We pass the data through map (key-value pairs) to set method
    return await quizCollection.doc(uid).set({
      'quizCategory': quizCategory,
      'quizTitle': quizTitle,
      'quizOwner': quizOwner,
      'quizDescription': quizDescription,
      'quizIsShared': quizIsShared,
    });
  }

  // ~ it's return value is Future, because it's async function
  // ! We call this function when user registers in auth.dart in order to add additional information besides provided in the registration form
  // * Here we update userData in DB
  Future updateUserData(
      String username, String email, String avatar, int level) async {
    // ~ Get the document based on the UID of the user
    // ~ If document does not exist yet, then Firebase will create the document with that UID. Thereby linking the Firestore document for that user with the Firebase User
    // ~ We pass the data through map (key-value pairs) to set method
    return await userDataCollection.doc(uid).set({
      'username': username,
      'email': email,
      'avatar': avatar,
      'level': level,
    });
  }

  // ! Difference between QuerySnapshot and DocumentSnapshot https://firebase.flutter.dev/docs/firestore/usage/
  // ~ Quiz list from snapshot
  // ! This returns list of ! ALL ! quizes from snapshot in DB
  List<Quiz> _quizListFromSnapshot(QuerySnapshot snapshot) {
    // ~ Return the brews from the database as list of objects Brew that we have created in models/brew.dart
    return snapshot.docs.map((doc) {
      return Quiz(
        // ~ ?? means if empty return ''
        quizCategory: doc.get('quizCategory') ?? '',
        quizTitle: doc.get('quizTitle') ?? '0',
        quizOwner: doc.get('quizOwner') ?? '0',
        quizDescription: doc.get('quizDescription') ?? '0',
        quizIsShared: doc.get('quizIsShared') ?? false,
      );
    }).toList();
  }

  // ! Difference between QuerySnapshot and DocumentSnapshot https://firebase.flutter.dev/docs/firestore/usage/
  // ~ Quiz list from snapshot
  // ! This returns list of shared quizes from snapshot in DB
/*  List<Quiz> _sharedQuizListFromSnapshot(QuerySnapshot snapshot) {
    // ~ Return the brews from the database as list of objects Brew that we have created in models/brew.dart
    return snapshot.docs.map((doc) {
      bool quizIsShared = doc.get('quizIsShared');
      if (quizIsShared) {
        return Quiz(
          // ~ ?? means if empty return ''
          quizCategory: doc.get('quizCategory') ?? '',
          quizTitle: doc.get('quizTitle') ?? '0',
          quizOwner: doc.get('quizOwner') ?? '0',
          quizDescription: doc.get('quizDescription') ?? '0',
          quizIsShared: doc.get('quizIsShared') ?? false,
        );
      } else {
        return Quiz(
          // ~ ?? means if empty return ''
          quizCategory: doc.get('quizCategory') ?? '',
          quizTitle: doc.get('quizTitle') ?? '0',
          quizOwner: doc.get('quizOwner') ?? '0',
          quizDescription: doc.get('quizDescription') ?? '0',
          quizIsShared: doc.get('quizIsShared') ?? false,
        );
      }
    }).toList();
  }*/

  // ~ Create new stream which will notify us about any changes in the quiz_collection in DB
  // Stream<QuerySnapshot> get brews{
  Stream<List<Quiz>> get quizes {
    // ! This now returns us a stream whith we will use in Home screen
    // ~ Here snapshot is taken from all entries
    return quizCollection.snapshots().map(_quizListFromSnapshot);
  }

  // ~ userData from snapshot
  // ~ Here we use DocumentSnapshot, so approach is a bit different than quisListFromSnapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    // ~ Convert snapshot to UserData class that we have created in models/user/
    return UserData(
      uid: uid,
      username: snapshot['username'],
      email: snapshot['email'],
      avatar: snapshot['avatar'],
      level: snapshot['level'],
    );
  }

  // ~ We create a new stream inside the database service class, which will be linked up to
  // ~ my firestore document. We will take UID and setup a stream with that document
  // ~ so whoever logins, it will be new stream. Only their document in the firestore database will be accesable to them
  // ! get user doc stream
  // Stream<DocumentSnapshot> get userData{
  Stream<UserData>? get userData {
    // ~ we return the stream of UserData
    // ! Here snapshot is taken ONLY from what user with this UID should see ( only his userData )
    Stream<UserData> stream =
        userDataCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
    // ~ We convert out stream to boardCastStream, so that multiple classes can be listeners ( by default it's one listener )
    return stream.asBroadcastStream();
  }
}
