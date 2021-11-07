import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ! The instance of DatabaseService is created in the class auth.dart when user is registered
class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});

  // ~ collection reference ( a reference to a particular collection on our firestore database )
  // ~ when we want to read or write from/into that collection, we will use this reference
  // ! If by the time this line is executed and 'brews' collection does not exist in Firebase, it will create it for us
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  // ~ it's return value is Future, because it's async function
  // ! We call this function when user registers in auth.dart
  Future updateUserData(String sugars, String name, int strength) async {
    // ~ Get the document based on the UID of the user
    // ~ If document does not exist yet, then Firebase will create the document with that UID. Thereby linking the Firestore document for that user with the Firebase User
    // ~ We pass the data through map (key-value pairs) to set method
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength' : strength,
    });
  }

  // ~ Create new stream which will notify us about any changes in the database
  Stream<QuerySnapshot> get brews{
    // ! This now returns us a stream whith we will use in Home screen
    return brewCollection.snapshots();
  }

}