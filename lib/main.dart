import 'package:crew_brew/screens/home/home.dart';
import 'package:crew_brew/screens/quizzes/add_new_quiz_ui.dart';
import 'package:crew_brew/screens/quizzes/my_quizzes.dart';
import 'package:crew_brew/screens/quizzes/quiz_wrapper.dart';
import 'package:crew_brew/screens/quizzes/shared_quizzes.dart';
import 'package:crew_brew/screens/quizzes/add_questions_ui.dart';
import 'package:crew_brew/screens/result/result.dart';
import 'package:crew_brew/screens/userProfile/userProfile.dart';
import 'package:crew_brew/screens/wrapper.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/screens/authenticate/register.dart';
import 'package:crew_brew/screens/authenticate/sign_in.dart';
import 'package:crew_brew/screens/authenticate/WelcomingScreen.dart';
import 'package:crew_brew/shared/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
          '/home': (context) => const NavContainer(page: Home()),
          '/userProfile': (context) => const NavContainer(page: userProfile()),
          '/sharedQuizes': (context) => NavContainer(page: SharedQuizes()),
          '/myQuizes': (context) => const NavContainer(page: MyQuizes()),
          '/welcome': (context) => const NavContainer(page: WelcominScreen()),
          '/register': (context) => const SignUp(),
          '/signin': (context) => const LogIn(),
          '/results': (context) => const NavContainer(page: Result()),
          '/quizWrapper': (context) => const QuizWrapper(),
          '/AddQuestionsUI': (context) => AddQuestionsUI(),
          '/AddNewQuizzUI': (context) => const AddNewQuizzUI(),
        },
        // TODO: Decide on a unified theme and copy it here
        theme: ThemeData.light().copyWith(
            backgroundColor: background, primaryColor: const Color(0xff309c9d)),
      ),
    );
  }
}
