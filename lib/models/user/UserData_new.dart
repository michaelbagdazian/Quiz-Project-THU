// ! This class represent an entry in the Firestore DB, e.g document
class UserData_new {
  final String uid;
  String username;
  String email;
  String avatar;
  int level;

  UserData_new(
      {required this.uid,
        required this.username,
        required this.email,
        required this.avatar,
        required this.level});
}