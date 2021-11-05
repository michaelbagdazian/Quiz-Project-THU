import 'package:crew_brew/screens/authenticate/authenticate.dart';
import 'package:crew_brew/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ~ return either Home or Authenticate widget
    return Authenticate();
  }
}
