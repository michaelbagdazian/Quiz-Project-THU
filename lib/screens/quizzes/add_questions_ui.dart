// ignore_for_file: file_names, void_checks

import 'dart:io';

import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/question.dart';
import 'package:crew_brew/navigationBar/menu_button.dart';
import 'package:crew_brew/services/AddQuestion.dart';
import 'package:crew_brew/services/database.dart';
import 'package:crew_brew/shared/customWidgets/customAlertBox.dart';
import 'package:crew_brew/shared/customWidgets/customConfirmationBox.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/customWidgets/customTextField.dart';
import 'package:crew_brew/shared/customWidgets/customButton.dart';
import 'package:crew_brew/shared/PorgressbarIndicator/step_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../models/quiz/answer.dart';

// ! Information about the class:
// ~ This class is a Page to create a quizz and questions to quizz
// ~ This class has both FrontEnd Code and Backend Code in it
// ~ Don't Try to understand everything in this class because you will get a headache
// ~ IF there is a bug in this class then we just going to have to live with it because crying for at least 3 hours straight just to fix a bug isn't worth it
// ~ Contact Person: Mohamad Arabi
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
  final TextEditingController _secondAnswer = TextEditingController();
  //~ Third Answer
  final TextEditingController _thirdAnswer = TextEditingController();
  //~ Fourth Answer
  final TextEditingController _fourthAnswer = TextEditingController();

  //~ instance of a CustomTextField
  final CustomTextField _customTextField = CustomTextField();

  //~instance of AddQuestions
  final AddQuestions _ListOfQuestions = AddQuestions();

  //~ Our Current Question; normally it should be the last question in our question list
  Question? _Currquestion = null;

  //~ These are bools that can be set/reset by the user with checkboxes
  bool? _isFirstAnswerCorrect = false;
  bool? _isSecondAnswerCorrect = false;
  bool? _isThirdAnswerCorrect = false;
  bool? _isFourthAnswerCorrect = false;

  //~ Progress bar instance
  late ValueNotifier<int> StepProgressBarIndicatorSteps;

  //~ Arguments from the Add Quizz Page (Quiz title, tags,Owner UId, etc...)
  late var args;

  int IsLastQuestion = 0;

  //* Build Widget Starts here
  @override
  Widget build(BuildContext context) {
    //~ Determining the number of total steps for the progress bar indicator
    StepProgressBarIndicatorSteps = _Currquestion == null
        ? ValueNotifier<int>(_ListOfQuestions.getQuestions().length + 1)
        : ValueNotifier<int>(
            _ListOfQuestions.getQuestions().indexOf(_Currquestion!) + 2);
    //~ getting the arguments from the previous screen
    args = ModalRoute.of(context)!.settings.arguments;
    //~ Get the size of the screen
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //~ this is here so we don't have an overflow problem
      //* AppBar
      appBar: AppBar(
        title: const Text(
          'New Quizz',
          style: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.teal,
        leading: const MenuButton(),
      ),
      //* Container of all widgets
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          //* Background
          image: DecorationImage(
              image: AssetImage('assets/images/bgtop.png'), fit: BoxFit.cover),
        ),
        child: Column(
          //* A Column that has it all
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            //* empty space
            SizedBox(
              height: size.height * 0.003,
            ),
            //* ProgressBar Starts here
            ValueListenableBuilder<int>(
                valueListenable: StepProgressBarIndicatorSteps,
                builder: (context, value, _) {
                  //* Row that contains two arrows and dashes
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //* Back Arrow
                      IconButton(
                        enableFeedback: true,
                        icon: const Icon(
                          //* Icon of the icon button (arrow)
                          Icons.arrow_back_ios_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () async => {
                          //? Decrementing dashes here
                          if (StepProgressBarIndicatorSteps.value > 1)
                            {
                              StepProgressBarIndicatorSteps.value--,
                            }
                          else
                            null,
                          //? getting the values of the current question
                          await PrintStuffOnScreen(),
                          //? set CurrQuestion as CurrQuestion.previous
                          goToPreviousQuestin(),
                        },
                      ),
                      SizedBox(
                        width: value * 1,
                      ),
                      //* Dashes
                      SizedBox(
                        width: size.width * 0.7,
                        child: StepProgressIndicator(
                          totalSteps: value,
                          currentStep: value,
                          selectedColor: Colors.orange,
                        ),
                      ),
                      SizedBox(
                        width: value * 1,
                      ),
                      //* Forward Arrow
                      IconButton(
                          enableFeedback: true,
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                          ),
                          onPressed: () async => {
                                //? Incrementing dashes here
                                if (StepProgressBarIndicatorSteps.value <
                                    _ListOfQuestions.getQuestions().length + 1)
                                  {
                                    StepProgressBarIndicatorSteps.value++,
                                  }
                                else
                                  null,
                                //? Set CurrQuestion as CurrQuestion.next
                                goToNextQuestion(),
                                //? getting the values of the current question
                                await PrintStuffOnScreen(),
                              }),
                    ],
                  );
                }),
            SizedBox(height: size.height * 0.01),
            //* Question Field
            SizedBox(
              width: size.width / 1.1,
              child: TextField(
                controller: _question, // Controller to control the text
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Question",
                  hintStyle: const TextStyle(
                    color: Colors.white60,
                    fontFamily: 'Lobster',
                    fontSize: 30,
                  ),
                  //* This is an icon that can be clicked to clear all, it is placed inside the Text Field
                  suffixIcon: IconButton(
                    //* Clear All icon
                    onPressed: () async {
                      //* Prompts the user to confirm
                      var conf = customConfirmationBox(
                          label: 'Please Confirm',
                          content:
                              'Are you sure you want to clear everthing ?');
                      //* stores what the user has choosen
                      bool val = await conf.ConfirmPopUp(context);
                      //* if it the user has confirmed, clear
                      if (val == true) clearFunc();
                    },
                    icon: const Icon(
                      Icons.layers_clear_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            //* empty space
            SizedBox(
              height: size.height * 0.07,
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
                _customTextField.customTextField(_secondAnswer, "Answer 2:",
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
              height: size.height - size.height * 0.87,
            ),
            //* 'Add Question' Button + 'Submit Quizz' Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //* Button To Submit the Quizz
                CustomButton(
                    label: "Submit",
                    backgroundcolor: Colors.orange,
                    function: submitButtonFunc),
                SizedBox(
                  width: size.width * 0.3,
                ),
                //* Button To Add a question
                FloatingActionButton(
                  child: const Icon(
                    Icons.add_sharp,
                  ),
                  backgroundColor: Colors.orange,
                  onPressed: () {
                    addQuestionButtonFunc(); //~
                  },
                  enableFeedback: true,
                  heroTag: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//~ This Future adds Questions to our current list of questions, this gets called everytime the user adds a question
  Future addQuestionButtonFunc() async {
    //~ This checks if we are adding a new question or editing an existing one
    if (_ListOfQuestions.Questions.isNotEmpty) {
      if (_Currquestion != _ListOfQuestions.getLastQuestion()) {
        //~ If editing, then we remove the old Question
        _ListOfQuestions.removeQuestion(_Currquestion!);
      }
    }
    //~ The Following int is used to check if there is no correct answers
    int _numberOfCorrectAnswers = 0;
    //~ Check how many correct answers are there
    if (_isFirstAnswerCorrect == true) _numberOfCorrectAnswers += 1;
    if (_isSecondAnswerCorrect == true) _numberOfCorrectAnswers += 1;
    if (_isThirdAnswerCorrect == true) _numberOfCorrectAnswers += 1;
    if (_isFourthAnswerCorrect == true) _numberOfCorrectAnswers += 1;

    //~ Create a map to store our answers in
    final List<Answer> answers = [];
    //~ Check if there is an answer to add at all
    if (_firstAnswer.text.isNotEmpty) {
      print("_firstAnswer.text.isNotEmpty");
      answers.add(new Answer(answerText: _firstAnswer.text, isCorrect: _isFirstAnswerCorrect!));
    }
    if (_secondAnswer.text.isNotEmpty) {
      print("_secondAnswer.text.isNotEmpty");
      answers.add(new Answer(answerText: _secondAnswer.text, isCorrect: _isSecondAnswerCorrect!));
    }
    if (_thirdAnswer.text.isNotEmpty) {
      answers.add(new Answer(answerText: _thirdAnswer.text, isCorrect: _isThirdAnswerCorrect!));
    }
    if (_fourthAnswer.text.isNotEmpty) {
      answers.add(new Answer(answerText: _fourthAnswer.text, isCorrect: _isFourthAnswerCorrect!));
    }

    //~ If user didn't mark at least one answer as correct answer
    if (_numberOfCorrectAnswers == 0 ||
        _question.text.isEmpty ||
        answers.isEmpty) {
      //~ show a alert box to inform user that they need to mark at least one answer as correct
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return customAlertBox("An Error Has Happened !!!",
                "Please Make Sure the question field is not empty and there is at least on correct answer");
          });
      //~ Exit this function
      return;
    }

    for(Answer answer in answers){
      print(answer.answerText);
    }

    //~ Add a new Question to the list of questions
    _ListOfQuestions.addNewQuestion(_question.text, answers, context);
    //~ Add a step in the progress indicator
    StepProgressBarIndicatorSteps.value++;
    //~ Move the pointer of the Current Question to get the new last question
    _Currquestion = _ListOfQuestions.getLastQuestion();
    //~ resets everything on screen
    clearFunc();
  }

//~ This function clears and resets everything (text fields and checkboxes) on the screen, this can be used when a new Question is to be Added or if user clicks on clear button
  VoidCallback? clearFunc() {
    _question.clear();
    _firstAnswer.clear();
    _secondAnswer.clear();
    _thirdAnswer.clear();
    _fourthAnswer.clear();

    _isFirstAnswerCorrect = false;
    _isSecondAnswerCorrect = false;
    _isThirdAnswerCorrect = false;
    _isFourthAnswerCorrect = false;
  }

  //~ This Future creates a new quizz object and adds the list of questions to it
  Future submitButtonFunc() async {
    //? this is so that if the user had one last question that they forgot to add, submit button will add it for them
    if (_question.text != "") addQuestionButtonFunc();
    // ignore: non_constant_identifier_names
    String QuizId = args['OwnerUId'] +
        "-" +
        DateTime.now().toString(); // unique quizz identifier
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
        quizID: QuizId);
//? Send the Quizz to firebase
    await DatabaseService(uid: _newQuizz.quizOwnerUID)
        .createQuizData(_newQuizz);

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          //customAlertBox (label, error message
          return customAlertBox("Quiz Submitted", "Have Fun!");
        });
    Navigator.popAndPushNamed(context, '/myQuizes');
  }

  //~This function is for navigating through questions (BackWards)
  void goToPreviousQuestin() {
    //~ Checks if we have at least one question in our list
    if (_Currquestion == null || _ListOfQuestions.getQuestions().length == 1) {
      return;
    }

    //~ Move CurrQuestion to the previous question, but we check if we have reached the first question, in which case, we don't go back anymore
    if (_ListOfQuestions.getQuestions().indexOf(_Currquestion!) > 0) {
      _Currquestion = _ListOfQuestions.getQuestions()[
          _ListOfQuestions.getQuestions().indexOf(_Currquestion!) - 1];
    }
  }

  //~This function is for navigating through questions (Forward)
  void goToNextQuestion() {
    if (_Currquestion == null || _ListOfQuestions.getQuestions().length == 1) {
      return;
    }
    if (_ListOfQuestions.getQuestions().indexOf(_Currquestion!) <
        _ListOfQuestions.getQuestions()
            .indexOf(_ListOfQuestions.getLastQuestion()!)) {
      _Currquestion = _ListOfQuestions.getQuestions()[
          _ListOfQuestions.getQuestions().indexOf(_Currquestion!) + 1];
    } else {
      _Currquestion != _ListOfQuestions.getLastQuestion();
      IsLastQuestion++;
    }
  }

//~ The Following Future prints the data of the current question on the screen
  Future PrintStuffOnScreen() async {
    //~ Edit the question controller to actually display the text from our current question
    _question.text = _Currquestion!.questionText;
    //~ ...
    _firstAnswer.text = _Currquestion!.answers[0].answerText;
    _secondAnswer.text = _Currquestion!.answers.length >= 2
        ? _Currquestion!.answers[1].answerText
        : "";
    _thirdAnswer.text = _Currquestion!.answers.length >= 3
        ? _Currquestion!.answers[2].answerText
        : "";
    _fourthAnswer.text = _Currquestion!.answers.length >= 4
        ? _Currquestion!.answers[3].answerText
        : "";
    _isFirstAnswerCorrect = _Currquestion!.answers[0].isCorrect;
    _isSecondAnswerCorrect = _Currquestion!.answers.length >= 2
        ? _Currquestion!.answers[1].isCorrect
        : false;
    _isThirdAnswerCorrect = _Currquestion!.answers.length >= 3
        ? _Currquestion!.answers[2].isCorrect
        : false;
    _isFourthAnswerCorrect = _Currquestion!.answers.length >= 4
        ? _Currquestion!.answers[3].isCorrect
        : false;

    //?check if we pressed forward again after our CurrQuestion=last question
    if (StepProgressBarIndicatorSteps.value >
        _ListOfQuestions.Questions.length) {
      clearFunc();
    }
  }
}
