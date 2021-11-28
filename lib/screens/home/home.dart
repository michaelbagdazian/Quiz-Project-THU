import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/models/user/UserData.dart';
import 'package:crew_brew/navigationBar/navbar.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:crew_brew/testClasses/manualQuizCreation.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/shared/colors.dart';

// ! Information about the class:
// ~ This class is represents home page of the user
// ! Use of the class:
// ~ For now this class alows to create private quiz ( colored with brown color ) and public quiz ( colored with blue color )

// ! TODOS:
// TODO Improve loading as done in welcome and sign_in with boolean loading variable
// TODO If after some time fetch of the AppUser or UserData was not successful, display error message
// TODO Define more meaningful Home Page

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // ! Provider.of<AppUser?>(context):
    // ~ Here we listen to the stream, defined in services/auth.dart, which informs us about login state of the user
    final user = Provider.of<AppUser?>(context);

    // ! If user is logged in, display the Home screen
    if (user != null) {
      // ! StreamBuilder<UserData>
      // ~ StreamBuilder is a widget that builds itself based on the latest snapshot of interaction with a stream
      // ~ Information about the UserData is forwarded down the stream ONLY for this class. The stream does not go below to children elements
      // ~ If the data is changed in the DB, it is immediately reflected in the Home screen ( for now there is nothing to reflect, since it consists of 2 buttons )
      return StreamBuilder<UserData>(
          // ~ Here we access the data provided in the stream, which is userData ( see user/UserData.dart to view accesable information )
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            UserData? userData = snapshot.data;

            // ! If we have successfully accessed the userData from the DB, return scaffold
            if (snapshot.hasData) {
              return Scaffold(
                // ! NavBar():
                // ~ Here we provide NavBar for property drawer. This is our navigation bar defined in navigationBar/navBar.dart
                drawer: NavBar(),
                backgroundColor: background,
                appBar: AppBar(
                  title: Text('Home Quiz App'),
                  backgroundColor: topbar,
                  elevation: 0.0,
                ),
                body: Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
                  child: Column(children: <Widget>[
                    SizedBox(height: 20.0),
                    // * Start of "create private quiz "
                    RaisedButton(
                        color: buttons,
                        child: Text(
                          'Create private quiz',
                          style: TextStyle(color: texts),
                        ),
                        // ! onPressed() :
                        // ~ When button is pressed, the quiz is created in the DB and is displayed in myQuizes, since it's private Quiz
                        onPressed: () async {
                          await DatabaseService(uid: user.uid)
                              .updateQuizData(ManualQuizeCreation()
                              .createTestQuiz(
                              user.uid, userData!.username, false));
                        }),
                    // * End of "create private quiz "
                    // * Start of "create public quiz "
                    RaisedButton(
                        color: buttons,
                        child: Text(
                          'Create public quiz',
                          style: TextStyle(color: texts),
                        ),
                        // ! onPressed() :
                        // ~ When button is pressed, the quiz is created in the DB and is displayed in myQuizes AND sharedQuizes, since it's public Quiz
                        onPressed: () async {
                          await DatabaseService(uid: user.uid)
                              .updateQuizData(ManualQuizeCreation()
                              .createTestQuiz(
                              user.uid, userData!.username, true));
                        }),
                    // * End of "create public quiz "
                  ]),
                ),
              );
              // ! If the user data from the DB is still fetching, return Loading
            } else {
              return Loading();
            }
          });
      // ! If user is not logged in or data is still fetching from DB, return Loading screen
    } else {
      return Loading();
    }
  }
}
