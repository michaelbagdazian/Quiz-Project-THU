import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/navigationBar/NavBar.dart';
import 'package:crew_brew/screens/quizes/quiz_list.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/services/database.dart';
import 'package:provider/provider.dart';

// ! Information about the class:
// ~ This class represents sharedQuizes Page
// ! Use of the class:
// ~ It shows quizes that are shared ( blue ).

// ! TODOS:
// TODO Improve loading as done in welcome and sign_in with boolean loading variable

class SharedQuizes extends StatelessWidget {
  SharedQuizes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ! StreamProvider<Quiz>
    // ~ Here we define StreamProvider based on the stream defined in services/database.dart
    // ~ Listens to a Stream and exposes its content to child and descendants.
    // ~ If the data is changed in the DB, it is immediately reflected in the myQzuies screen and any screens below in widget tree
    return StreamProvider<List<Quiz>?>.value(
      initialData: null,
      // ! value
      // ~ Here we define to which stream we will listen to
      // ~ We do not provide any UID, because we do not need it. We access shared quizes, not private quizes
      value: DatabaseService(uid: '').sharedQuizes,
      child: Scaffold(
        // ! NavBar():
        // ~ Here we provide NavBar for property drawer. This is our navigation bar defined in navigationBar/navBar.dart
        drawer: NavBar(),
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Quiz App'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
        ),
        // ! This is the body of our app, which consists of the background and shared quizes of all users
        body: Container(
            // ! BoxDecoration:
            // ~ A widget that lets you draw arbitrary graphics.
            // ~ We use it to display the backround image of the body
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/home_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            // ! QuizList:
            // ~ This is where List is generated
            // ~ Stream List<Quiz> is provided to this child
            child: QuizList()),
      ),
    );
  }
}
