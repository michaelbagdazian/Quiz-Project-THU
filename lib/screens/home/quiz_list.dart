import 'package:crew_brew/models/Quiz.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'quiz_tile.dart';

// ! This widget is responsible for outputting different brews on the page
class QuizList extends StatefulWidget {
  const QuizList({Key? key}) : super(key: key);

  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  @override
  Widget build(BuildContext context) {
    // ~ We access the quizes from here. It's updated when some changes to the database occur
    // ~ The provider is defined in home.dart class
    final quizes = Provider.of<List<Quiz>?>(context);
    if (quizes != null) {
      quizes.forEach((quiz) {
        print(quiz.quizCategory);
        print(quiz.quizTitle);
        print(quiz.quizOwner);
        print(quiz.quizDescription);
        print(quiz.quizIsShared);
      });

      return ListView.builder(
        itemCount: quizes.length,
        // ~ itemBuilder is the function in itself which is going to return some kind of template or a widget tree for each item inside the list
        itemBuilder: (context, index) {
          return QuizTile(quiz: quizes[index]);
        },
      );
    } else {
      return Loading();
    }

//print(quizes?.docs.toString());
/* final quizes = Provider.of<QuerySnapshot?>(context);
    if(quizes?.docs != null ){
      for(var doc in quizes!.docs){
        print(doc.data());
      }
    }
     */
  }
}
