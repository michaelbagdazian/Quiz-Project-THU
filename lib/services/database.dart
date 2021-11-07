import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew_brew/models/AppUser.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/models/brew.dart';

// ! The instance of DatabaseService is created in the class auth.dart when user is registered
class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // ~ collection reference ( a reference to a particular collection on our firestore database )
  // ~ when we want to read or write from/into that collection, we will use this reference
  // ! If by the time this line is executed and 'brews' collection does not exist in Firebase, it will create it for us
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  // ~ it's return value is Future, because it's async function
  // ! We call this function when user registers in auth.dart
  Future updateUserData(String sugars, String name, int strength) async {
    // ~ Get the document based on the UID of the user
    // ~ If document does not exist yet, then Firebase will create the document with that UID. Thereby linking the Firestore document for that user with the Firebase User
    // ~ We pass the data through map (key-value pairs) to set method
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // ~ brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    // ~ Return the brews from the database as list of objects Brew that we have created in models/brew.dart
    return snapshot.docs.map((doc) {
      return Brew(
          // ~ ?? means if empty return ''
          name: doc.get('name') ?? '',
          sugars: doc.get('sugars') ?? '0',
          strength: doc.get('strength') ?? 0);
    }).toList();
  }

  // ~ userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    // ~ Convert snapshot to UserData class that we have created in models/AppUser.dart
    return UserData(
        uid: uid,
        name: snapshot['name'],
        sugars: snapshot['sugars'],
        strength: snapshot['strength']);
  }

  // ~ Create new stream which will notify us about any changes in the database
  // Stream<QuerySnapshot> get brews{
  Stream<List<Brew>> get brews {
    // ! This now returns us a stream whith we will use in Home screen
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // ~ We create a new stream inside the database service class, which will be linked up to
  // ~ my firestore document. We will take UID and setup a stream with that document
  // ~ so whoever logins, it will be new stream. Only their document in the firestore database
  // ! get user doc stream
  // Stream<DocumentSnapshot> get userData{
  Stream<UserData> get userData {
    // ~ we return the stream of UserData
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
