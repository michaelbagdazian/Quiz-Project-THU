import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/navigationBar/menu_button.dart';
import 'package:crew_brew/screens/quizzes/my_and_shared_quizes/quiz_list.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/shared/colors.dart';

/// ignore_for_file: file_names, non_constant_identifier_names
/// ! Information about the class:
/// ~ This class represents myQuizes Page
/// ! Use of the class:
/// ~ It shows quizes that belong to current user. They can be shared ( blue ) or not shared ( brown )
/// ! TODOS:
/// TODO Improve loading as done in welcome and sign_in with boolean loading variable
/// TODO Do the scheck if Quiz data was succesfully fetched from the DB
/// TODO Move searchBar to separate widget so it can be reused by myQuizes and sharedQuizes

class MyQuizes extends StatefulWidget {
  @override
  _MyQuizes createState() => _MyQuizes();

  const MyQuizes({Key? key}) : super(key: key);
}

class _MyQuizes extends State<MyQuizes> {
  Icon cusIcon = const Icon(Icons.search);
  Widget cusSearchBar = const Text("My Quizes");
  String searchInput = ""; ///holds the text you input to the search box

  @override
  Widget build(BuildContext context) {
    /// ! Provider.of<AppUser?>(context):
    /// ~ Here we listen to the stream, defined in services/auth.dart and provided by main.dart, which informs us about login state of the user
    /// ~ We need user instance to have acess to DatabaseService instance
    final user = Provider.of<AppUser?>(context);

    /// ! If user is logged in, display the myQuizes page
    if (user != null) {
      /// ! StreamProvider<Quiz>
      /// ~ Here we define StreamProvider based on the stream defined in services/database.dart
      /// ~ Listens to a Stream and exposes its content to child and descendants.
      /// ~ If the data is changed in the DB, it is immediately reflected in the myQzuies screen and any screens below in widget tree
      return StreamProvider<List<Quiz>?>.value(
        initialData: null,
        /// ! value
        /// ~ Here we define to which stream we will listen to
        value: DatabaseService(uid: user.uid).myQuizes,
        child: Scaffold(
          /// ! NavBar():
          /// ~ Here we provide NavBar for property drawer. This is our navigation bar defined in navigationBar/navBar.dart
          backgroundColor: background,
          appBar: AppBar(
            title: cusSearchBar,
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (cusIcon.icon == Icons.search) {
                        cusIcon = const Icon(Icons.cancel);
                        cusSearchBar = TextField(
                            /// ~ This replaces the button on the keyboard of the device
                            textInputAction: TextInputAction.go,
                            /// ~ When 'go' button is pressed, current widget is informed about state change
                            onSubmitted: (text) =>
                                setState(() => searchInput = text),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search",
                            ),
                            style: const TextStyle(
                              color: texts,
                              fontSize: 16.0,
                            ));
                      } else {
                        searchInput = "";
                        cusIcon = const Icon(Icons.search);
                        cusSearchBar = const Text("My Quizes");
                      }
                    });
                  },
                  icon: cusIcon)
            ],
            backgroundColor: topbar,
            elevation: 0.0,
            leading: const MenuButton(),
          ),
          /// ! This is the body of our app, which consists of the background and Quizes of current user
          body: Container(
              /// ! BoxDecoration:
              /// ~ A widget that lets you draw arbitrary graphics.
              /// ~ We use it to display the backround image of the body
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/home_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              /// ! QuizList:
              /// ~ This is where List is generated
              /// ~ Stream List<Quiz> is provided to this child
              child: QuizList(searchInput: searchInput)),
        ),
      );
      /// ! If user is not logged in or data is still fetching from DB, return Loading screen
    } else {
      return Loading();
    }
  }
}
