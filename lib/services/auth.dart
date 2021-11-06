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
  AppUser? _userFromFirebaseUser(User? user){
    return user != null ? AppUser(uid: user.uid) : null;
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

  // * sign out

}