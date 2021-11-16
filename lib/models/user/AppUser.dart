// ! Infomartion about the class:
// ~ This class represents the User instance from Firestore Database, but we define our own for convenience.
// ! Use of class:
// ~ In services/auth.dart we return the instance of this class in method _userFromFirebaseUser and then make use of it in the defined Stream<AppUser>.

// ! TODOS:
// all done

class AppUser {
  // ~ UID is all we need to understand if user is logged-in or not
  final String uid;

  AppUser({required this.uid});
}
