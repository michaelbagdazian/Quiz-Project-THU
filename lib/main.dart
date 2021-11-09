import 'package:crew_brew/screens/wrapper.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/models/user/AppUser.dart';

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
    return StreamProvider<AppUser?>.value(
      // ~ what stream we want to listen to and which data do we expect to get back
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
