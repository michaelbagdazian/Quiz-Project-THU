// ! Information about the class:
// ~ This class represent an entry collection in the Firestore DB called 'user_data'. The entry in the Firestore DB is created after user has registered.
// ! Use of the class:
// ~ It is used in services/database.dart in the method _userDataFromSnapshot, where we convert DocumentSnapshot to the instance UserData
// ~ and then make use of it in the defined Stream<UserData>

// ! TODOS:
// all done

class UserData {
  final String uid;
  String username;
  String email;
  String avatar;
  int level;

  UserData(
      {required this.uid,
      required this.username,
      required this.email,
      required this.avatar,
      required this.level});
}
