import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/screens/quizes/active_quiz.dart';
import 'package:crew_brew/services/database.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew_brew/models/user/AppUser.dart';

class QuizWrapper extends StatelessWidget {
  const QuizWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    if(data != null){
      Quiz quiz = data['quiz'];
      print("quizID: " + quiz.quizID);
      return ActiveQuiz(questions: quiz.listOfQuestions);
    }else{
      return Loading();
    }
   /* // ! Provider.of<AppUser?>(context):
    // ~ Here we listen to the stream, defined in services/auth.dart and provided by main.dart, which informs us about login state of the user
    final user = Provider.of<AppUser?>(context);

    return StreamBuilder<List<Quiz>>(
        // ~ Here we access the data provided in the stream, which is userData ( see user/UserData.dart to view accesable information )
        stream: DatabaseService(uid: user!.uid).myQuizes,
        builder: (context, snapshot) {
          // ! If there is a data for current user in the DB, then assign it to the variables, otherwise display Loading screen
          if (snapshot.hasData) {
            List<Quiz>? quizes = snapshot.data;
            if (quizes != null) {
              return ActiveQuiz(questions: quizes[0].listOfQuestions);
            } else {
              return Loading();
            }
          } else {
            return Loading();
          }
        });*/
  }
}
