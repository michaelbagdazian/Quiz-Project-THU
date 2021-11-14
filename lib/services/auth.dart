import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ! Information about the class:
// ~ This class is a service class for user authentication
// ! Use of the class:
// ~ Here we define all methods that are going to interact with firebase_auth for us

// ! TODOS:
// all done

class AuthService {
  // ! FireBaseAuth:
  // ~ Create an instance of our firebase authentication
  // ~ This object will then allow us to communicate with firebase auth on the backend
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ! _userFromFirebaseUser
  // ~ this function creates customer user object we have created in user/AppUser based on Firebase User
  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // ! Stream<AppUser?>
  // ~ Here we define the stream for the changes in user authentication ( logged in or logged out ) and then main.dart will provide the stream to children
  Stream<AppUser?> get user {
    // ! authStateChanges()
    // ~ authStateChanges notifies about changes to the user's sign-in state (such as sign-in or sign-out)
    return _auth
        .authStateChanges()
        // ~ every time we get Firebase User inside the stream, it will map it to our AppUser that we created
        .map(_userFromFirebaseUser);
  }

  // * sign in anonymously
  // ~ Future - If the asynchronous operation succeeds, the future completes with a value. Otherwise it completes with an error.
  Future signInAnon() async {
    try {
      // ~ we make authentication request and we want to await this, because this will take some time to do
      // ~ and we want to wait for completion before we assign the result to some kind of variable
      // ~ in result we have the access to user object, which represents user
      UserCredential result = await _auth.signInAnonymously();

      // ~ we want to turn this into our own custome user based on user class we have created
      User? user = result.user;

      // ~ When we call signInAnon method from signIn page, then it will return user object to that sign in widget where we called this method
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // * sign in with e-mail and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      // ~ First we do request to FireBase and it awaits for the response
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // ~ we obtain the result and store it in user variable. It can be with data or null
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // * register with e-mail and password
  Future registerWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      // ~ First we do request to FireBase and it awaits for the response
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // ~ we obtain the result and store it in user variable. It can be with data or null
      User? user = result.user;

      // ~ create a document in Firestore Database for that user with the UID
      // ~ Together with the Firebase User instance we create the entry of User Data in the Firebase
      // ~ Username and email is provided, level is 0 and avatar is default
      await DatabaseService(uid: user!.uid)
          .updateUserData(username, email, 'default.png', 0);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // * sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
