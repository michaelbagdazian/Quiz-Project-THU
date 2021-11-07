// ~ This class contains the information of the user while he navigates between
// ~ different screen of our app

class AppUser {
  final String uid;

  AppUser({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData(
      {required this.uid,
      required this.name,
      required this.sugars,
      required this.strength});
}
