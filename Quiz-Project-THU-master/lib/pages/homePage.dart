// ignore_for_file: file_names, camel_case_types


import 'package:flutter/material.dart';
import 'package:test_pro/HomeCards/Achievments.dart';
import 'package:test_pro/HomeCards/Create_Quize.dart';
import 'package:test_pro/HomeCards/UserCard.dart';
import 'package:test_pro/nagivation/NavBar.dart';
import 'package:test_pro/HomeCards/Quiz.dart';
import 'package:test_pro/HomeCards/JoinCard.dart';


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


      appBar: AppBar(
        title: Text(accountName),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,

        leading: Padding(
        padding: const EdgeInsets.all(8.0),


        //shows your account avatar in circle shape
        child: ClipOval(
          //user icon in oval shape
          child: Image.asset(
            'assets/menu_images/$avatar',
            fit: BoxFit.cover,
          ),
        ),
      ),
      ),

        // main opartof the home screen
        body: Stack( children: <Widget>[
          new Container(
            decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("assets/images/mainpage_background.jpg"), fit: BoxFit.fill)), //<- background immage of the main screen
          ),


          SingleChildScrollView(
                child: Column(
                  children: [
                    // card for the main scrren
                  QuizCard(),
                  CreateQCard(),
                    UserCard(),
                    AchievmentCard(),
                    JoinCard(),
                  ],
                ),
              )
        ]
        )
    );
  }
}




