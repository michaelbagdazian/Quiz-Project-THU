import 'package:crew_brew/screens/authenticate/authenticate.dart';
import 'package:crew_brew/screens/home/home.dart';
import 'package:crew_brew/screens/authenticate/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/models/user/AppUser.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ~ Access if the user loged in or loged out
    // ! We have defined provider in main.dart
    final user = Provider.of<AppUser?>(context);
    // ~ return either Home or Authenticate widget
    if (user == null) {
      // return Authenticate();
      return Welcome();
    } else {
      return Home();
    }
  }
}
