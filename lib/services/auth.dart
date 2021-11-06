import 'package:crew_brew/models/AppUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ! Here we define all methods that are going to interact with firebase_auth for us
class AuthService{

  // ~ Create an instance of our firebase authentication
  // ~ This object will then allow us to communicate with firebase auth on the backend
  // ~ _ in auth means auth property is private and it can only be used in this file
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ~ this function creates user object based on Firebase User
  // ~ this is a private function ( _ means it's private )
  // ! the question mark means that this <type>? can possibly be null and flutter will allow you to assign null to it
  AppUser? _userFromFirebaseUser(User? user){
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // ~ auth change user stream
  Stream<AppUser?> get user {
    // ~ authStateChanges notifies about changes to the user's sign-in state (such as sign-in or sign-out)
    return _auth.authStateChanges()
        // ~ This is the same as thing above, just shorter
        .map(_userFromFirebaseUser);
        // ~ every time we get Firebase User inside the stream, it will map it to our AppUser that we created
        // .map((User? user) => _userFromFirebaseUser(user));
  }

  // * sign in anonymosly
  // ~ Future - If the asynchronous operation succeeds, the future completes with a value. Otherwise it completes with an error.
  Future signInAnon() async {
    try{
      // ~ we make authentication request and we want to await this, because this will take some time to do and we want to wait this is complete
      // ~ before we assign the result to some kind of variable
      // ~ in result we have the access to user object, which represents user
      UserCredential result = await _auth.signInAnonymously();
      // ~ we want to turn this into our own custome user based on user class we have created
      User? user = result.user;
      // ~ When we call signInAnon method from signIn page, then it will return user object to that sign in widget where we called this method
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // * sign in with e-mail and password

  // * register with e-mail and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      // ~ First we do request to FireBase and it awaits for the response
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // ~ we want to turn this into our own custome user based on user class we have created
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // * sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}