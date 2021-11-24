import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/colors.dart';
import 'package:crew_brew/shared/colors.dart';

// ! Information about the class:
// ~ This class represents ONE entry in the List
// ! Use of the class:
// ~ It's used as a template for ListView entry in screens/quizes/quiz_list.dart

// ! TODOS:
// all done

class QuizTile extends StatelessWidget {
  const QuizTile({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("true"),             //<- here logic when your click the tile
      child: Card(
        //add a 3d aspeckt for the card
        elevation: 8.0,
        clipBehavior: Clip.antiAlias,

        //set the distance between the card and the phone border
        margin: EdgeInsets.fromLTRB(20.0, 9.0, 20.0, 9.0),

        //change the corners of the app
        //so its circular
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),

        child: Padding(

          // the distance between the contetent of the card and the corder of the card
          padding: const EdgeInsets.all(14.0),

          //Title
          child: Column(
              children: [
                //for the titel text of the card
                Text.rich(
                  TextSpan(
                    //textstyle of the title
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.indigo
                    ),

                      children: [
                        //title of the quiz
                      TextSpan(
                        text: quiz.quizTitle,
                      ),
                      // icon for identication if the quiz is shared red = not, green = is shared.
                      WidgetSpan(
                        child: Icon(Icons.group, color: quiz.quizIsShared ? right : wrong),
                      ),
                    ],
                  ),
                ),

                //middle part of the card where the picture and describtion is stackede
                Stack(children: [

                  //alignment where the picture should be
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        //how big the picture should and the card itself
                        height: MediaQuery.of(context).size.height* 0.15,width: MediaQuery.of(context).size.height* 0.13,
                         child: Image.asset("assets/images/eddu.png", ) //<- here should be logik to change the picture
                    )
                    ),

                  // discribtion
                  Center(child:
                        Padding(

                      //is for that the text and the picture dont overlape
                      //change the possition of the text
                  padding: const EdgeInsets.fromLTRB(1, 3, 110, 30),

                          //where the text shoul be
                          child: Align(alignment: Alignment.topLeft,

                          //text content
                          child: Text(quiz.quizDescription,style:

                      //style of the text
                          TextStyle(
                          fontWeight: FontWeight.bold,
                           color: bluething,
                            fontSize: 20,
                          )
                        ),
                      ),
                    ),
                  ),

                  //where the bottom text should be
                  Align(
                    //verticaly possuition of the text
                    heightFactor: MediaQuery.of(context).devicePixelRatio*1.6,
                    alignment: Alignment.bottomLeft,
                      child:
                  Text(quiz.quizOwner,style:
                      //text style
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: bluething,
                    fontSize: 20,

                  )
                  )
                  )
                ]),
              ]
          ),
        ),
      ),
    );
  }
}