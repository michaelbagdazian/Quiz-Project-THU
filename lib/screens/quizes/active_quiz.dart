import 'package:crew_brew/components/quiz/quiz_component.dart';
import 'package:crew_brew/models/quiz/question.dart';
import 'package:flutter/material.dart';

// ~ Done by Luke

class ActiveQuiz extends StatefulWidget {
  final List<Question> questions;
  const ActiveQuiz({Key? key, required this.questions}) : super(key: key);

  @override
  _ActiveQuizState createState() => _ActiveQuizState();
}

class _ActiveQuizState extends State<ActiveQuiz> {
  int currentQuestion = 0;

  void next() {
    if (currentQuestion == widget.questions.length - 1) {
      // TODO: Show Score Screen Here
      setState(() {
        currentQuestion = 0;
      });
    } else {
      setState(() {
        currentQuestion++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                padding:
                    EdgeInsets.all((theme.textTheme.bodyText2!.fontSize)! * 1),
                child: Text(
                  "Question ${currentQuestion + 1}/${widget.questions.length}",
                  style: theme.textTheme.headline4!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              Flexible(
                  flex: 1,
                  child: QuizComponent(
                    questionText: widget.questions
                        .elementAt(currentQuestion)
                        .questionText,
                    answers:
                        widget.questions.elementAt(currentQuestion).answers,
                    answer: 1,
                    onCorrectAnswer: () {
                      print("Correct");
                    },
                    onWrongAnswer: () {
                      print("Wrong");
                    },
                    onFinishAnswer: next,
                  )),
              TextButton(onPressed: next, child: const Text("Submit"))
            ]),
      ),
    );
  }
}
