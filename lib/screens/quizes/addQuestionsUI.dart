// ignore_for_file: file_names, void_checks

import 'dart:io';

import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/question.dart';
import 'package:crew_brew/services/AddQuestion.dart';
import 'package:crew_brew/services/database.dart';
import 'package:crew_brew/shared/customWidgets/customAlertBox.dart';
import 'package:crew_brew/shared/customWidgets/customConfirmationBox.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/customWidgets/customTextField.dart';
import 'package:crew_brew/shared/customWidgets/customButton.dart';

// ! Information about the class:
// ~ This class is a Page to create a quizz and questions to quizz
// ! Use of the class:
// ~ This has 5 text fields, one for the question and 4 for the answers.
// ~ it allows the user to add questions to their quizz

class AddQuestionsUI extends StatefulWidget {
  //constructor
  AddQuestionsUI({Key? key}) : super(key: key);

  @override
  State<AddQuestionsUI> createState() => _AddQuestionsUIState();
}

class _AddQuestionsUIState extends State<AddQuestionsUI> {
  //defining some TextEditingControllers to handle user's input
  //~ Question Text
  final TextEditingController _question = TextEditingController();
  //~ First Answer
  final TextEditingController _firstAnswer = TextEditingController();
  //~ Second Answer
  final TextEditingController _secondtAnswer = TextEditingController();

  final TextEditingController _thirdAnswer = TextEditingController();

  final TextEditingController _fourthAnswer = TextEditingController();
  //~ instance of a CustomTextField
  final CustomTextField _customTextField = CustomTextField();
  //~instance of AddQuestions
  final AddQuestions _ListOfQuestions = AddQuestions();

  //~ These are bools that can be set/reset by the user with checkboxes
  bool? _isFirstAnswerCorrect = false;
  bool? _isSecondAnswerCorrect = false;
  bool? _isThirdAnswerCorrect = false;
  bool? _isFourthAnswerCorrect = false;

  late var args;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments;
    //~ Get the size of the screen
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
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bgtop.png'), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            //* empty space
            SizedBox(
              height: size.height * 0.09,
            ),
            //* Question
            Container(
              width: size.width / 1.1,
              child: TextField(
                controller: _question,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: "Question",
                  hintStyle: TextStyle(
                    color: Colors.white60,
                    fontFamily: 'Lobster',
                    fontSize: 30,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            //* empty space
            SizedBox(
              height: size.height * 0.1,
            ),
            //* Text Field + Checkbox next to it
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //* field for answer 1
                _customTextField.customTextField(_firstAnswer, "Answer 1:",
                    size.width / 1.3, TextInputType.text),
                //* Checkbox for answer 1
                Checkbox(
                    value: _isFirstAnswerCorrect,
                    onChanged: (bool? value) {
                      setState(() {
                        _isFirstAnswerCorrect = value;
                      });
                    }),
              ],
            ),
            //* empty space
            SizedBox(
              height: size.height * 0.02,
            ),
            //* Text Field + Checkbox next to it
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _customTextField.customTextField(_secondtAnswer, "Answer 2:",
                    size.width / 1.3, TextInputType.text),
                Checkbox(
                    value: _isSecondAnswerCorrect,
                    onChanged: (bool? value) {
                      setState(() {
                        _isSecondAnswerCorrect = value;
                      });
                    }),
              ],
            ),
            //* empty space
            SizedBox(
              height: size.height * 0.02,
            ),
            //* Text Field + Checkbox next to it
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _customTextField.customTextField(_thirdAnswer, "Answer 3:",
                    size.width / 1.3, TextInputType.text),
                Checkbox(
                    value: _isThirdAnswerCorrect,
                    onChanged: (bool? value) {
                      setState(() {
                        _isThirdAnswerCorrect = value;
                      });
                    }),
              ],
            ),
            //* empty space
            SizedBox(
              height: size.height * 0.02,
            ),
            //* Text Field + Checkbox next to it
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _customTextField.customTextField(_fourthAnswer, "Answer 4:",
                    size.width / 1.3, TextInputType.text),
                Checkbox(
                    value: _isFourthAnswerCorrect,
                    onChanged: (bool? value) {
                      setState(() {
                        _isFourthAnswerCorrect = value;
                      });
                    }),
              ],
            ),
            //* empty space
            SizedBox(
              height: size.height * 0.05,
            ),
            //* 'Add Question' Button + 'Submit Quizz' Button
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                    label: "Add New Question",
                    backgroundcolor: Colors.orange,
                    function: addQuestionButtonFunc),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomButton(
                    label: "Clear",
                    backgroundcolor: Colors.orange,
                    function: () async {
                      //* Prompts the user to confirm
                      var conf = customConfirmationBox(
                          label: 'Please Confirm',
                          content:
                              'Are you sure you want to clear everthing ?');
                      //* stores what the user has choosen
                      bool val = await conf.ConfirmPopUp(context);
                      //* if it the user has confirmed, clear
                      if (val == true) clearFunc();
                    }),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomButton(
                    label: "Submit",
                    backgroundcolor: Colors.orange,
                    function: submitButtonFunc),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future addQuestionButtonFunc() async {
    //~ Create a list of answers to actually pass to when we want to Add a new Question
    List<String> _usersAnswers = <String>[];
    _usersAnswers.add(_firstAnswer.text);
    _usersAnswers.add(_secondtAnswer.text);
    _usersAnswers.add(_thirdAnswer.text);
    _usersAnswers.add(_fourthAnswer.text);

    //~ Create A list of Correct Answers
    List<int> _correctAnswers = <int>[];
    //~ Adding Correct Answers to the list
    if (_isFirstAnswerCorrect == true) _correctAnswers.add(1);
    if (_isSecondAnswerCorrect == true) _correctAnswers.add(2);
    if (_isThirdAnswerCorrect == true) _correctAnswers.add(3);
    if (_isFourthAnswerCorrect == true) _correctAnswers.add(4);

    //~ If user didn't mark at least one answer as correct answer
    if (_correctAnswers.isEmpty) {
      //~ show a alert box to inform user that they need to mark at least one answer as correct
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            //customAlertBox (label, error message
            return customAlertBox("An Error Has Happened !!!",
                "Please Mark At least one Answer as Correct");
          });
      //~ Exit this function
      return;
    }
    //~ Add a new Question to the list of questions
    _ListOfQuestions.addNewQuestion(
        _question.text, _usersAnswers, _correctAnswers, context);
    //~ resets everything on screen
    clearFunc();
  }

//~ This function clears and resets everything (text fields and checkboxes) on the screen, this can be used when a new Question is to be Added or if user clicks on clear button
  VoidCallback? clearFunc() {
    _question.clear();
    _firstAnswer.clear();
    _secondtAnswer.clear();
    _thirdAnswer.clear();
    _fourthAnswer.clear();

    _isFirstAnswerCorrect = false;
    _isSecondAnswerCorrect = false;
    _isThirdAnswerCorrect = false;
    _isFourthAnswerCorrect = false;
  }

  Future submitButtonFunc() async {
    // if (_question.text.isNotEmpty) addQuestionButtonFunc();
    Quiz _newQuizz = Quiz(
      quizCategory: args['QuizzCategory'],
      quizTitle: args['QuizzTitle'],
      quizOwner: args['UserName'],
      quizOwnerUID: args['OwnerUId'],
      quizDescription: args['QuizzDescription'],
      quizIsShared: args['isQuizzPublic'],
      listOfQuestions: _ListOfQuestions.getQuestions(),
      tags: args['Tags'],
      quizID: args['OwnerUId'],
    );
    print(args['OwnerUId']);

    await DatabaseService(uid: _newQuizz.quizOwnerUID)
        .updateQuizData(_newQuizz);
  }
}
