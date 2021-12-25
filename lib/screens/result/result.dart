import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/models/quiz/game_state.dart';
import 'package:crew_brew/models/quiz/quiz_state.dart';
import 'package:crew_brew/navigationBar/menu_button.dart';
import 'package:crew_brew/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Map data = ModalRoute.of(context)!.settings.arguments as Map;
    final args = ModalRoute.of(context)!.settings.arguments as QuizState;
    ThemeData theme = Theme.of(context);
    //Quiz quiz = (data['quiz'] as Quiz);
    final em = theme.textTheme.bodyText2?.fontSize ?? 16;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: topbar,
        leading: const MenuButton(),
        elevation: 0.0,
      ),
      body: /* Text(
        args.quiz.quizTitle +"\n"
            + args.quiz.listOfQuestions.toString() +"\n"
            + args.quiz.listOfQuestions[0].questionText +"\n"
            + args.stateVector.toString(),
      ),*/
          //sorry had to comment that out to run things - holger
          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2 * em, bottom: 2 * em),
            child: Text(
              "You got ${args.stateVector.playerPoints[0].sum.toString()}/${args.quiz.listOfQuestions.length}",
              textAlign: TextAlign.center,
              style: theme.textTheme.headline5,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                for (var i = 0; i < args.quiz.listOfQuestions.length; i++) //
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(1 * em),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 1.5 * em, bottom: 2 * em),
                            child: Text(
                              args.quiz.listOfQuestions[i].questionText,
                              style: theme.textTheme.headline6,
                            ),
                          ),
                          Column(children: <Widget>[
                            for (var j = 0;
                                j < args.quiz.listOfQuestions[i].answers.length;
                                j++)
                              Container(
                                margin: EdgeInsets.all(0.5 * em),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: args.stateVector.buttonsPressed[0]
                                            [j]
                                        ? Border.all(color: Colors.black)
                                        : null,
                                    color: args.quiz.listOfQuestions[i]
                                            .answers[j].isCorrect
                                        ? Colors.green
                                        : Colors.red),
                                child: Padding(
                                  padding: EdgeInsets.all(1.5 * em),
                                  child: Text(args.quiz.listOfQuestions[i]
                                      .answers[j].answerText),
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
          Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/sharedQuizes'),
                child: const Text("back"),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    primary: Colors.greenAccent,
                    padding: const EdgeInsets.all(20)),
              )),
        ],
      ),
    );
  }
}
