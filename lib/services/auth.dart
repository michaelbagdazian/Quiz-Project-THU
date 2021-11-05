import 'package:firebase_auth/firebase_auth.dart';

// ! Here we define all methods that are going to interact with firebase_auth for us
class AuthService{

  // ~ Create an instance of our firebase authentication
  // ~ This object will then allow us to communicate with firebase auth on the backend
  // ~ _ in auth means auth property is private and it can only be used in this file
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // * sign in anonymosly
  // ~ Future - If the asynchronous operation succeeds, the future completes with a value. Otherwise it completes with an error.
  Future signInAnon() async {
    try{
      // ~ we make authentication request and we want to await this, because this will take some time to do and we want to wait this is complete
      // ~ before we assign the result to some kind of variable
      // ~ in result we have the access to user object, which represents user
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      // ~ When we call signInAnon method from signIn page, then it will return user object to that sign in widget where we called this method
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // * sign in with e-mail and password

  // * register with e-mail and password

  // * sign out

}