// ignore_for_file: file_names

import 'package:crew_brew/models/quiz/question.dart';
import 'package:crew_brew/shared/customWidgets/customAlertBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddQuestions {
  late List<Question> Questions;
  AddQuestions() {
    Questions = <Question>[];
  }

  //~ Add Question to Questions
  void addNewQuestion(String questionText, List<String> answers,
      List<int> correctAnswers, BuildContext _context) {
    try {
      /*
      ! the follwing statement needs to be changed later
      ! for now this is just temporary
      ! please change the properties of Class Question so that it can take multiple correct answers
      */

      int correctAnswer = correctAnswers.elementAt(0);
      //! this is done this way so that we fulfill the properties of class Question, BUT PLEASE CHANGE THIS AFTERWARDS

      //~ Create a new Question
      Question? _question = Question(
          questionText: questionText,
          answers: answers,
          correctAnswer: correctAnswer);
      // _question.correctAnswers = correctAnswers;
      //~ Add the new Question to the list of questions
      Questions.add(_question);
      //~ Delete Question, for memory managment
      _question = null;
    } catch (e) {
      print(e.toString());
    }
  }

  //~ removes a question object from Questions by reference
  void removeQuestion(Question _question) {
    try {
      Questions.remove(_question);
    } catch (e) {
      print(e.toString());
    }
  }

  //~ removes a question object from Questions by index
  void removeQuestionByIndex(int index) {
    try {
      Questions.removeAt(index);
    } catch (e) {
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
}
