// ignore_for_file: file_names

import 'package:crew_brew/models/quiz/question.dart';
import 'package:crew_brew/shared/customWidgets/customAlertBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/quiz/answer.dart';

// ! Information about the class:
// ~ This class Allows us to create a list of Questions and add/remove/access questions to/from it
// ! Use of the class:
// ~ This is used when a user adds new questions to a quizz or creates a new quizz
// ~ we pass the list of Questions to an object Quizz

class AddQuestions {
  //~ List of Questions
  late List<Question> Questions;
  //~ Constructur initializes the list of questions as an empty list when it is called
  AddQuestions() {
    Questions = <Question>[];
  }

  void setQuestions(List<Question> Questions) {
    this.Questions = Questions;
  }

  /*
  ~ The Following function is used to Add Question to the list of Questions
  ~ it takes 4 arguments:
  ~   String questionText: the question it self as a string
  ~   List <String> answers: a list of answers as strings
  ~   List <int> correctAnswers: list of integers to determine the correct answers
  ~   Build _context: A Build Context for error handling and alertboxes
  */
  void addNewQuestion(
      String questionText, List<Answer> answers, BuildContext _context) {
    try {
      //~ Create a new instance of Question
      Question? _question =
          Question(questionText: questionText, answers: answers);

      //~ Add the new Question to the list of questions
      Questions.add(_question);
      //~ Delete Question, for memory managment
      _question = null;
    } catch (e) {
      //~ Debugging Statement, it can/should be turned into an alertbox later
      print(e.toString());
    }
  }

  void EditOldQuestion(String questionText, List<Answer> answers,
      BuildContext _context, Question currQuestion) {
    try {
      Questions.elementAt(Questions.indexOf(currQuestion)).answers = answers;
      Questions.elementAt(Questions.indexOf(currQuestion)).questionText =
          questionText;
    } catch (e) {
      //~ Debugging Statement, it can/should be turned into an alertbox later
      print(e.toString());
    }
  }

  // TODO Comments
  void changeOldQuestion(
      String questionText, List<Answer> answers, BuildContext _context) {
    try {
      //~ Create a new instance of Question
      Question? _question =
      Question(questionText: questionText, answers: answers);

      //~ Add the new Question to the list of questions
      Questions.add(_question);
      //~ Delete Question, for memory managment
      _question = null;
    } catch (e) {
      //~ Debugging Statement, it can/should be turned into an alertbox later
      print(e.toString());
    }
  }

  //~ removes a question object from Questions by reference
  void removeQuestion(Question _question) {
    try {
      Questions.remove(_question);
    } catch (e) {
      //~ Debugging Statement
      print(e.toString());
    }
  }

  //~ removes a question object from Questions by index
  void removeQuestionByIndex(int index) {
    try {
      Questions.removeAt(index);
    } catch (e) {
      //~ Debugging Statement
      print(e.toString());
    }
  }

  //~ getter for Questions
  List<Question> getQuestions() {
    return Questions;
  }

//~ shuffles Questions randomly
  void shuffleQuestions() {
    Questions.shuffle();
  }

  Question? getLastQuestion() {
    if (getQuestions().isNotEmpty) {
      return getQuestions()[getQuestions().length - 1];
    }
    return null;
  }
}
