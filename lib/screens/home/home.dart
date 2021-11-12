import 'package:crew_brew/models/Quiz.dart';
import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/models/user/UserData.dart';
import 'package:crew_brew/navigationBar/NavBar.dart';
import 'package:crew_brew/screens/quizes/quiz_list.dart';
import 'package:crew_brew/screens/home/settings_form.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    if(user!=null){
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            UserData? userData = snapshot.data;

            return Scaffold(
              drawer: NavBar(),
              backgroundColor: Colors.brown[50],
              appBar: AppBar(
                title: Text('Home Quiz App'),
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
              ),
              // * This is the body of our app, which consists of the background and Quizes of ! ALL ! users
              body: Padding(
                padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Create private quiz',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await DatabaseService(uid: user.uid)
                            .updateQuizData('default', 'default quiz create from Home', userData!.username, 'this is default quiz', false);
                      }),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Create public quiz',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await DatabaseService(uid: user.uid)
                            .updateQuizData('default', 'default quiz create from Home', userData!.username, 'this is default quiz', true);
                      }),
                ]),
              ),
            );
          }
      );
    }else{
      return Loading();
    }
  }
}
