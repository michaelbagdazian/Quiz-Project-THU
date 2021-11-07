import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // ~ collection reference ( a reference to a particular collection on our firestore database )
  // ~ when we want to read or write from/into that collection, we will use this reference
  // ! If by the time this line is executed and 'brews' collection does not exist in Firebase, it will create it for us
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
}