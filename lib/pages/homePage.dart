import 'package:flutter/material.dart';
import 'package:test_pro/nagivation/NavBar.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    // ~ Fetch the data passed from NavBar
    data = ModalRoute.of(context)!.settings.arguments as Map;
    String accountName = data['accountName'];
    String accountEmail = data['accountEmail'];
    String avatar = data['avatar'];

    return Scaffold(
      // ~ This add a menu icon on top left
      drawer: NavBar(
        // TODO 1 Here the information should be delivered from login page
        // TODO 2 Create Person class where information has to be stored
        // ~ Passing parameters to navigation bar
        accountName: accountName,
        accountEmail: accountEmail,
        avatar: avatar,
      ),
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Home page'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      body: Center(),
    );
  }
}
