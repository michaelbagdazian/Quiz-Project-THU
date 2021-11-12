import 'package:crew_brew/screens/home/home.dart';
import 'package:crew_brew/screens/quizes/sharedQuizes.dart';
import 'package:crew_brew/screens/userProfile/userProfile.dart';
import 'package:crew_brew/screens/wrapper.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/models/user/AppUser.dart';

import 'models/user/UserData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ~ If the user is signed in, we want to show Home screen
    // ~ so we need a way to provide that stream data to the root widget
    // ~ so that it can listen to authChanges and provide the information down below
    // ! we will use package " Provider " for this
    return MultiProvider(
      providers: [
        StreamProvider<AppUser?>.value(
            value: AuthService().user, initialData: null),
       /* StreamProvider<UserData?>.value(
          value: DatabaseService(uid: 'V5p7vIYlFNapXhQWFGE1m7MlwLq1').userData,
          initialData: null)*/
      ],
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          '/home': (context) => Home(),
          '/userProfile': (context) => userProfile(),
          '/sharedQuizes': (context) => SharedQuizes(),
        },
      ),
    );
  }
}
