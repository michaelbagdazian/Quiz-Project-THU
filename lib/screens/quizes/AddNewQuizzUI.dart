// ignore_for_file: file_names

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/question.dart';
import 'package:crew_brew/models/user/AppUser.dart';
import 'package:crew_brew/models/user/UserData.dart';
import 'package:crew_brew/screens/quizes/addQuestionsUI.dart';
import 'package:crew_brew/services/database.dart';
import 'package:crew_brew/shared/customWidgets/customAlertBox.dart';
import 'package:crew_brew/shared/customWidgets/customButton.dart';
import 'package:crew_brew/shared/customWidgets/customText.dart';
import 'package:crew_brew/shared/customWidgets/customTextField.dart';
import 'package:crew_brew/testClasses/manualQuizCreation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';

class AddNewQuizzUI extends StatefulWidget {
  @override
  State<AddNewQuizzUI> createState() => _AddNewQuizzUIState();
}

class _AddNewQuizzUIState extends State<AddNewQuizzUI> {
  final TextEditingController QuizzTitle = TextEditingController();
  final TextEditingController? QuizzDescription = TextEditingController();
  final TextEditingController? tags = TextEditingController();
  //? List of Categories
  var categories = <String>[
    'Music',
    'Sport',
    'Games',
    'History',
    'CS',
    'Phyiscs',
    'Math',
    'Trivia',
    'Other',
  ];
  String dropDownVal = 'Other';

  bool? isQuizzPublic = false;

  UserData? userData = null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //~ this is here so we don't have an overflow problem
      appBar: AppBar(
        title: const Text(
          'New Quizz',
          style: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bgtop.png'), fit: BoxFit.cover),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: size.height * 0.07,
              ),
              CustomText().customText('Creating A New Quizz'),
              //* Empty space
              SizedBox(
                height: size.height * 0.07,
              ),
              //* Text Field for Quizz name
              CustomTextField().customTextField(QuizzTitle, 'Quizz Title',
                  size.width * 0.7, TextInputType.text),
              //* Empty space
              SizedBox(
                height: size.height * 0.013,
              ),
              //* Text Field for Quizz name
              CustomTextField().customTextField(QuizzDescription!,
                  'Short Description', size.width * 0.7, TextInputType.text),
              //* Empty space
              SizedBox(
                height: size.height * 0.013,
              ),
              //* Text Field for Quizz name
              CustomTextField().customTextField(
                  tags!, 'Tags', size.width * 0.7, TextInputType.text,
                  hint: 'e.g: funny, nice, hard'),
              //* Empty space
              SizedBox(
                height: size.height * 0.02,
              ),
              //* Drop Down menu + Text
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //* Text 'Category'
                  CustomText().customText('Category: ',
                      fontsize: 25,
                      fontweight: FontWeight.w100,
                      forgroundColor: Colors.transparent,
                      backgroundColor: Colors.white),
                  //* Empty space
                  SizedBox(width: size.width * 0.04),
                  //* Drop Down menu
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      dropdownMaxHeight: size.height *
                          0.3, //drop down menu is smaller but scrollable
                      buttonHeight: 40, //eyecandy
                      buttonWidth: (size.width * 0.7) * 0.5, //eyecandy
                      itemHeight: 40, //eyecandy
                      itemWidth: (size.width * 0.7) * 0.5, //eyecandy
                      //aligns text inside button
                      alignment: Alignment.bottomCenter,
                      //hint text
                      hint: const Text('Category'),
                      dropdownColor:
                          Colors.white70, //make the menu a bit transparent
                      // font style of the items
                      style: const TextStyle(
                          fontFamily: 'Lobster',
                          fontSize: 25,
                          color: Colors.black),
                      //arrow icon
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white54,
                      ),
                      //drop menu items
                      //~ We take the items that we want to display and we convert to a map
                      items: categories.map((String category) {
                        return DropdownMenuItem(
                          child: Text(category),
                          value: category,
                        );
                      }).toList(),
                      //value that is displayed on the menu, and to be changed later
                      value:
                          dropDownVal, //~ we convert the whole thing to a list to iterate over items
                      onChanged: (String? value) {
                        setState(() {
                          //~ now dropDownVal has the value that the user has selected
                          dropDownVal = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              //* Empty space
              SizedBox(height: size.height * 0.04),
              //* Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText().customText(
                    'Public: ',
                    fontsize: 25,
                    fontweight: FontWeight.w100,
                    forgroundColor: Colors.transparent,
                    backgroundColor: Colors.white,
                  ),
                  Checkbox(
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      value: isQuizzPublic,
                      onChanged: (bool? value) {
                        setState(() {
                          isQuizzPublic = value;
                        });
                      }),
                ],
              ),
              //* Empty space
              SizedBox(height: size.height * 0.04),
              CustomButton(
                  label: 'Start',
                  backgroundcolor: Colors.orange,
                  function: startFunc),
            ]),
      ),
    );
  }

  Future startFunc() async {
    if (QuizzTitle.text.isEmpty) {
      return showDialog(
          context: context,
          builder: (context) {
            return customAlertBox(
                'QuizzTitle', 'Please Add a QuizzTitle First');
          });
    }
    try {
      //~ get the current user (logged in) here
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        //~ instance of database services class
        DatabaseService databaseservices = DatabaseService(uid: user.uid);
        //~ get userdata from snapshot
        var userDataFromSnapshot = await databaseservices.userDataCollection
            .doc(user.uid)
            .get()
            .then((QuerySnapshot) {
          //~ we get the users data here by converting a snapshot to our UserData object
          userData = databaseservices.userDataFromSnapshot(QuerySnapshot);
        });
      }
      String UserName =
          userData!.username.isNotEmpty ? userData!.username : 'Anonymous';
      String QuizzDesc = QuizzDescription != null
          ? QuizzDescription!.text
          : 'just another quizz';
      String ChoosenCategory = dropDownVal;
      List<String> ListOfTags =
          tags != null ? tags!.text.split(',') : ['generic'];
      Navigator.popAndPushNamed(context, '/AddQuestionsUI', arguments: {
        'UserName': UserName,
        'QuizzTitle': QuizzTitle.text,
        'QuizzCategory': ChoosenCategory,
        'isQuizzPublic': isQuizzPublic,
        'OwnerUId': userData!.uid,
        'QuizzDescription': QuizzDescription!.text,
        'Tags': ListOfTags,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
