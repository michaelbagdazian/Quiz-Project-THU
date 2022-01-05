import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/screens/authenticate/WelcomingScreen.dart';
import 'package:crew_brew/screens/authenticate/register.dart';
import 'package:crew_brew/screens/authenticate/sign_in.dart';
import 'package:crew_brew/screens/home/home.dart';
import 'package:crew_brew/screens/quizzes/add_quiz/add_new_quiz_ui.dart';
import 'package:crew_brew/screens/quizzes/add_quiz/add_questions_ui.dart';
import 'package:crew_brew/screens/quizzes/edit_quiz/edit_old_questions_ui.dart';
import 'package:crew_brew/screens/quizzes/edit_quiz/edit_old_quiz_ui.dart';
import 'package:crew_brew/screens/quizzes/my_and_shared_quizes/my_quizzes.dart';
import 'package:crew_brew/screens/quizzes/my_and_shared_quizes/shared_quizzes.dart';
import 'package:crew_brew/screens/quizzes/quiz_wrapper.dart';
import 'package:crew_brew/screens/result/result.dart';
import 'package:crew_brew/screens/wrapper.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/shared/colors.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:crew_brew/testClasses/TestScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigationBar/nav_container.dart';
// ! Information about the class:
// ~ Main class
// ! Use of the class:
// ~ Root of our app

// ! TODOs
// all done

void main() async {
  // ~ Initialize fireBase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ! StreamProvider<AppUser?>
    // ~ Here we create StreamProvider, which is defined in services/auth.dart and provide the information
    // ~ about user authentication among all the classes of our app, since this Stream is defined at the root
    return StreamProvider<AppUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: const Wrapper(),
        // ! routes
        // ~ Here we define all routes of our apps. They are mainly used in navigationBar/navBar.dart -> selectedItem()
        routes: {
          '/testScreen': (context) => const NavContainer(page: TestScreen()),
          '/home': (context) => /*const*/ const NavContainer(page: Home()),
          '/sharedQuizes': (context) => NavContainer(page: SharedQuizes()),
          '/myQuizes': (context) => const NavContainer(page: MyQuizes()),
          '/welcome': (context) => NavContainer(page: WelcominScreen()),
          '/register': (context) => const SignUp(),
          '/signin': (context) => const LogIn(),
          '/results': (context) => const NavContainer(page: Result()),
          '/quizWrapper': (context) => const QuizWrapper(),
          '/AddQuestionsUI': (context) => AddQuestionsUI(),
          '/AddNewQuizzUI': (context) => const AddNewQuizzUI(),
          '/EditOldQuizUI': (context) => const EditQuizzUI(),
          '/EditQuestionsUI': (context) => const EditQuestionsUI(),
          '/loading': (context) => Loading()
        },
        // TODO: Decide on a unified theme and copy it here
        theme: ThemeData.light()
            .copyWith(backgroundColor: background, primaryColor: welcomeh),
      ),
    );
  }
}
