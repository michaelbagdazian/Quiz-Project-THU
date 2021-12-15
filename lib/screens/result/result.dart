import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/navigationBar/menu_button.dart';
import 'package:crew_brew/shared/colors.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    ThemeData theme = Theme.of(context);
    Quiz quiz = (data['quiz'] as Quiz);
    final em = theme.textTheme.bodyText2?.fontSize ?? 16;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: topbar,
        leading: const MenuButton(),
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2 * em, bottom: 2 * em),
            child: Text(
              "You got ${data['points'].toString()}/${quiz.listOfQuestions.length}",
              textAlign: TextAlign.center,
              style: theme.textTheme.headline5,
            ),
          ),
          Expanded(
            child: ListView(
              children: quiz.listOfQuestions
                  .map((question) => Card(
                        child: Padding(
                          padding: EdgeInsets.all(1 * em),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 1.5 * em, bottom: 2 * em),
                                child: Text(
                                  question.questionText,
                                  style: theme.textTheme.headline6,
                                ),
                              ),
                              Column(
                                children: question.answers
                                    .map((entry) => Container(
                                          margin: EdgeInsets.all(0.5 * em),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: entry.isCorrect
                                                  ? Colors.green
                                                  : Colors.red),
                                          child: Padding(
                                            padding: EdgeInsets.all(1.5 * em),
                                            child: Text(entry.answerText),
                                          ),
                                        ))
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
