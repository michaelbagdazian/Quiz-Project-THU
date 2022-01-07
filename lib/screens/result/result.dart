import 'package:collection/collection.dart';
import 'package:crew_brew/models/quiz/quiz_state.dart';
import 'package:crew_brew/services/database.dart';
import 'package:crew_brew/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user/AppUser.dart';
import '../../models/user/UserData.dart';
import '../../shared/loading.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  bool pointsAdded = false;


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as QuizState;
    ThemeData theme = Theme.of(context);
    final em = theme.textTheme.bodyText2?.fontSize ?? 16;

    ///method to get to total points possible in a quiz (since none or multiple answers per question can be correct)
    ///just sums over all questions and there all answers if it is correct
    int getTotalPoints(){
      int ret = 0;
      for (int i = 0; i < args.quiz.listOfQuestions.length; i++){
        for (int j = 0; j < args.quiz.listOfQuestions[i].answers.length; j++) {
          if (args.quiz.listOfQuestions[i].answers[j].isCorrect == true) {
            ret++;
          }
        }
      }
    return ret;
    }

    /// ! update user points in DB
    final user = Provider.of<AppUser?>(context);

    if (user != null) {
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(!pointsAdded){
                UserData? userData = snapshot.data;
                String username = userData!.username;
                String email = userData.email;
                String avatar = userData.avatar;
                int points = userData.points + args.stateVector.playerPoints[0].sum;
                DatabaseService(uid: user.uid)
                    .updateUserData(username, email, avatar, points);

                pointsAdded = true;
              }

              /// ! Finish updating user points in DB

              return Scaffold(
                backgroundColor: background,
                body: SafeArea(
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bgtop.png'),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2 * em),
                          child: SizedBox(
                              width: 7 * em,
                              height: 7 * em,
                              child: CircularProgressIndicator(
                                color: theme.primaryColor,
                                strokeWidth: 10,
                                value: args.stateVector.playerPoints[0].sum /
                                    args.quiz.listOfQuestions.length,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2 * em, bottom: 2 * em),
                          child: Text(
                            "You got ${args.stateVector.playerPoints[0].sum.toString()}/${getTotalPoints()}",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headline5!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        ///create a box for each question i and in there another rectangle for each answer j, color it green if it is correct, or red if it is not.
                        ///also have a k index for every question that appears, since questions can have different numbers of answers
                        ///k index corresponds to position in buttonsPressedSaved array. so if there is a true at positions k in the array
                        ///there is and additional border drawn to show the user what they have pressed
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              for (var i = 0, k = 0;
                              i < args.quiz.listOfQuestions.length;
                              i++) //
                                Card(
                                  color: const Color.fromARGB(25, 0, 0, 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: EdgeInsets.all(1 * em),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 1.5 * em, bottom: 2 * em),
                                          child: Text(
                                            args.quiz.listOfQuestions[i]
                                                .questionText,
                                            style: theme.textTheme.headline6!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                        Column(children: <Widget>[
                                          for (var j = 0;
                                          j <
                                              args.quiz.listOfQuestions[i]
                                                  .answers.length;
                                          j++, k++)
                                            Container(
                                              margin: EdgeInsets.all(0.5 * em),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  border: args.stateVector
                                                      .buttonsPressedSaved[
                                                  0][k]
                                                      ? Border.all(
                                                      color: Colors
                                                          .tealAccent
                                                          .shade400,
                                                      width: 4)
                                                      : null,
                                                  color: args
                                                      .quiz
                                                      .listOfQuestions[i]
                                                      .answers[j]
                                                      .isCorrect
                                                      ? Colors.green
                                                      : Colors.red),
                                              child: Padding(
                                                padding:
                                                EdgeInsets.all(1.5 * em),
                                                child: Text(
                                                    args.quiz.listOfQuestions[i]
                                                        .answers[j].answerText,
                                                    style: theme
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                        color:
                                                        Colors.white)),
                                              ),
                                            )
                                        ])
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        ///the button for the route to the shared quiz list
                        Padding(
                          padding: EdgeInsets.only(top: 1 * em),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () =>
                                      Navigator.pushReplacementNamed(
                                          context, '/sharedQuizes'),
                                  child: const Text("back"),
                                  style: ElevatedButton.styleFrom(
                                      primary: theme.primaryColor,
                                      padding: const EdgeInsets.all(20)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Loading();
            }
          });
    } else {
      return Loading();
    }
  }
}
