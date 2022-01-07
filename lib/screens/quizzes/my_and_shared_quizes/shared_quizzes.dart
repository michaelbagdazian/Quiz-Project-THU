import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/navigationBar/menu_button.dart';
import 'package:crew_brew/screens/quizzes/my_and_shared_quizes/quiz_list.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/shared/colors.dart';

/// ignore_for_file: file_names, non_constant_identifier_names
/// ! Information about the class:
/// ~ This class represents sharedQuizes Page
/// ! Use of the class:
/// ~ It shows quizes that are shared ( blue ).

/// ! TODOS:
/// TODO Improve loading as done in welcome and sign_in with boolean loading variable
/// TODO Move searchBar to separate widget so it can be reused by myQuizes and sharedQuizes

class SharedQuizes extends StatefulWidget {
  SharedQuizes({Key? key}) : super(key: key);

  @override
  State<SharedQuizes> createState() => _SharedQuizesState();
}

class _SharedQuizesState extends State<SharedQuizes> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Shared Quizes");
  String searchInput = ""; ///holds the

  @override
  Widget build(BuildContext context) {
    /// ! StreamProvider<Quiz>
    /// ~ Here we define StreamProvider based on the stream defined in services/database.dart
    /// ~ Listens to a Stream and exposes its content to child and descendants.
    /// ~ If the data is changed in the DB, it is immediately reflected in the myQzuies screen and any screens below in widget tree
    return StreamProvider<List<Quiz>?>.value(
      initialData: null,
      /// ! value
      /// ~ Here we define to which stream we will listen to
      /// ~ We do not provide any UID, because we do not need it. We access shared quizes, not private quizes
      value: DatabaseService(uid: '').sharedQuizes,
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
                    if (this.cusIcon.icon == Icons.search) {
                      this.cusIcon = Icon(Icons.cancel);
                      this.cusSearchBar = TextField(
                          /// ~ This replaces the button on the keyboard of the device
                          textInputAction: TextInputAction.go,
                          /// ~ When 'go' button is pressed, current widget is informed about state change
                          onSubmitted: (text) =>
                              setState(() => searchInput = text),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                          ),
                          style: TextStyle(
                            color: texts,
                            fontSize: 16.0,
                          ));
                    } else {
                      this.searchInput = "";
                      this.cusIcon = Icon(Icons.search);
                      this.cusSearchBar = Text("Shared Quizes");
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
            child: QuizList(searchInput: this.searchInput)),
      ),
    );
  }
}
