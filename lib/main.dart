import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/screens/home/home.dart';
import 'package:crew_brew/screens/quizes/AddNewQuizzUI.dart';
import 'package:crew_brew/screens/quizes/myQuizes.dart';
import 'package:crew_brew/screens/quizes/quizWrapper.dart';
import 'package:crew_brew/screens/quizes/sharedQuizes.dart';
import 'package:crew_brew/screens/quizes/addQuestionsUI.dart';
import 'package:crew_brew/screens/userProfile/userProfile.dart';
import 'package:crew_brew/screens/wrapper.dart';
import 'package:crew_brew/services/AddQuestion.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/screens/authenticate/register.dart';
import 'package:crew_brew/screens/authenticate/sign_in.dart';
import 'package:crew_brew/screens/authenticate/WelcomingScreen.dart';
import 'package:crew_brew/shared/colors.dart';
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
          '/home': (context) => Home(),
          '/userProfile': (context) => const userProfile(),
          '/sharedQuizes': (context) => SharedQuizes(),
          '/myQuizes': (context) => MyQuizes(),
          '/welcome': (context) => WelcominScreen(),
          '/register': (context) => SignUp(),
          '/signin': (context) => LogIn(),
          '/quizWrapper': (context) => QuizWrapper(),
          '/AddQuestionsUI': (context) => AddQuestionsUI(),
          '/AddNewQuizzUI': (context) => AddNewQuizzUI(),
        },
        // TODO: Decide on a unified theme and copy it here
        theme: ThemeData.light().copyWith(
          backgroundColor: background,
        ),
      ),
    );
  }
}
