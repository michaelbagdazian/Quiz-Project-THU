// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:crew_brew/shared/customWidgets/customTextField.dart';
import 'package:crew_brew/shared/customWidgets/customButton.dart';

// ! Information about the class:
// ~ This class is a Page to create a quizz and questions to quizz
// ! Use of the class:
// ~ This has 5 text fields, one for the question and 4 for the answers.
// ~ it allows the user to add questions to their quizz

class AddQuizUi extends StatefulWidget {
  //constructor
  AddQuizUi({Key? key}) : super(key: key);

  @override
  State<AddQuizUi> createState() => _AddQuizUiState();
}

class _AddQuizUiState extends State<AddQuizUi> {
  final TextEditingController _question = TextEditingController();

  final TextEditingController _fitstAnswer = TextEditingController();

  final TextEditingController _secondtAnswer = TextEditingController();

  final TextEditingController _thirdAnswer = TextEditingController();

  final TextEditingController _fourthAnswer = TextEditingController();

  final CustomTextField _customTextField = CustomTextField();

  bool? _isFirstAnswerCorrect = false;
  bool? _isSecondAnswerCorrect = false;
  bool? _isThirdAnswerCorrect = false;
  bool? _isFourthAnswerCorrect = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            SizedBox(
              height: size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //field for answer 1
                _customTextField.customTextField(_fitstAnswer, "Answer 1:",
                    size.width / 1.3, TextInputType.text),
                Checkbox(
                    value: _isFirstAnswerCorrect,
                    onChanged: (bool? value) {
                      setState(() {
                        _isFirstAnswerCorrect = value;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
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
            SizedBox(
              height: size.height * 0.02,
            ),
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
            SizedBox(
              height: size.height * 0.02,
            ),
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
            SizedBox(
              height: size.height * 0.05,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton()
                    .customButton("Add Question", Colors.orange, null),
                SizedBox(
                  height: size.height * 0.07,
                ),
                CustomButton().customButton("Submit", Colors.orange, null),
              ],
            ),
          ],
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
