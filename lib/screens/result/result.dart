import 'package:crew_brew/navigationBar/menu_button.dart';
import 'package:crew_brew/shared/colors.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: topbar,
        leading: const MenuButton(),
        elevation: 0.0,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
