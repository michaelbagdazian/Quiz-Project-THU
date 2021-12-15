import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/customWidgets/customAlertBox.dart';

// ! Information about the class:
// ~ This class is a service class for user authentication
// ! Use of the class:
// ~ Here we define all methods that are going to interact with firebase_auth for us

// ! TODOS:
// TODO when anonymous user logges out, fix [ERROR:flutter/lib/ui/ui_dart_state.cc(209)] Unhandled Exception: Null check operator used on a null value

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

  // * sign in with e-mail and password
  // * As you can see, the method takes a parameter of type BuildContext,
  // * context is used for error handeling, to actually know, what context to use when we need to build the alertbox
  //* when you call this method just pass in context like so => signInWithEmailAndPassword(email, password, context)
  Future signInWithEmailAndPassword(
      String email, String password, Function showError) async {
    try {
      // ~ First we do request to FireBase and it awaits for the response
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // ~ we obtain the result and store it in user variable. It can be with data or null
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      //~ catch firebase exception
      //~ execute callback function passed from sign_in.dart which builds an alert box with a title and the message of the exception
      showError("Log-in error!", e.message);
    }
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
  // * As you can see, the method takes a parameter of type BuildContext,
  // * context is used for error handeling, to actually know, what context to use when we need to build the alertbox
  //* when you call this method just pass in context like so => signInAnon(context)
  // ~ Future - If the asynchronous operation succeeds, the future completes with a value. Otherwise it completes with an error.
  Future signInAnon(Function showError, {String displayName = ""}) async {
    displayName = displayName == "" ? "Anonymous" : displayName;
    try {
      // ~ we make authentication request and we want to await this, because this will take some time to do
      // ~ and we want to wait for completion before we assign the result to some kind of variable
      // ~ in result we have the access to user object, which represents user
      UserCredential result = await _auth.signInAnonymously();

      // ~ we want to turn this into our own custome user based on user class we have created
      User? user = result.user;

      // ~ create a document in Firestore Database for that user with the UID
      // ~ Together with the Firebase User instance we create the entry of User Data in the Firebase
      // ~ Username and email is provided, level is 0 and avatars is default
      await DatabaseService(uid: user!.uid)
          .updateUserData(displayName, 'anonymous@gmail.com', 'anon.png', 0);

      // ~ When we call signInAnon method from signIn page, then it will return user object to that sign in widget where we called this method
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      //~ catch firebase exception
      //~ execute callback function passed from sign_in.dart which builds an alert box with a title and the message of the exception
      showError("Log-in error!", e.message);
    }
  }

  // * register with e-mail and password
  // * As you can see, the method takes a parameter of type BuildContext,
  // * context is used for error handeling, to actually know, what context to use when we need to build the alertbox
  //* when you call this method just pass in context like so => registerWithEmailAndPassword(username, pass, context)
  Future registerWithEmailAndPassword(String username, String email,
      String password, Function showError) async {
    try {
      // ~ First we do request to FireBase and it awaits for the response
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // ~ we obtain the result and store it in user variable. It can be with data or null
      User? user = result.user;

      // ~ create a document in Firestore Database for that user with the UID
      // ~ Together with the Firebase User instance we create the entry of User Data in the Firebase
      // ~ Username and email is provided, level is 0 and avatars is default
      await DatabaseService(uid: user!.uid)
          .updateUserData(username, email, 'default.png', 0);

      return _userFromFirebaseUser(user);
      //~ catch firebase exceptiom
    } on FirebaseAuthException catch (e) {
      //~ execute callback function passed from sign_in.dart which builds an alert box with a title and the message of the exception
      showError("Register error!", e.message);
    }
  }

  // * sign out
  // * As you can see, the method takes a parameter of type BuildContext,
  // * context is used for error handeling, to actually know, what context to use when we need to build the alertbox
  Future signOut(BuildContext context) async {
    try {
      // ~ If user was signedIn anounymosly, then all the data, as well as the user is deleted from the Firebase and Firestore
      if (_auth.currentUser!.isAnonymous) {
        // ~ We do not use await statement, since we do not want user to wait until data is deleted. So delete() is the fastest executed command
        // ~ As soon as delete() return a result, user is navigated to welcome screen, but in the background data is deleted from the DB
        String uid = _auth.currentUser!.uid;
        DatabaseService(uid: uid).deleteAllQuizesPerUID();
        DatabaseService(uid: uid).deleteUserData();
        // ~ When user is deleted, it's automatically logged out
        return _auth.currentUser!.delete();
      } else {
        return await _auth.signOut();
      }
    } on FirebaseAuthException catch (e) {
      //~ catch firebase exceptiom
      return showDialog(
          //~ return a showDialog which builds an alert box with a title and the message of the exception
          context: context,
          builder: (BuildContext context) {
            //customAlertBox (label, error message)
            return customAlertBox("Oops !! and error has happened", e.message);
          });
    }
  }
}
