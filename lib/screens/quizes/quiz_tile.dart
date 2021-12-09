import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/shared/colors.dart';
import 'quiztile_resource/dialog.dart';
import 'quiztile_resource/image_funktion.dart';

// ! Information about the class:
// ~ This class represents ONE entry in the List
// ! Use of the class:
// ~ It's used as a template for ListView entry in screens/quizes/quiz_list.dart

// ! TODOS:
// all done

//this funtion is for selecting the background pickture depending of the catrgory
class QuizTile extends StatelessWidget {

  const QuizTile({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;
  @override
  Widget build(BuildContext context) {
    // set the string backPicture with the quizcategory
    String backPickture = quiz.quizCategory;

    return GestureDetector(
      //when the card is pressed it oppends a new one
      onTap: () => Navigator.of(context).push(HeroDialogRoute(builder: (context) {
      return  _PopupCard(quiz : quiz);})),
      child: Hero(tag: _heroAddTodo,
          child: Card(
            elevation: 8.0,
            clipBehavior: Clip.antiAlias,
           //set the distance between the card and the phone border
            margin: const EdgeInsets.fromLTRB(20.0, 9.0, 20.0, 9.0),
            //change the corners of the appso its circular
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              //here the background for the card is set
              child: Container(
              decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover,
                //this funtion set the background immage
                image: AssetImage(image(backPickture)))),

              child: Padding(
              // the distance between the contetent of the card and the corder of the card
              padding: const EdgeInsets.all(14.0),
              //Content of the card
              child: Column(
                children: [
                //Title and Shared Icon
                Stack(children:[
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 70, 0),
                    // is for the background of the text
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.shade500,
                        borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                    )),
                      child: Text(quiz.quizTitle,
                          style: const TextStyle(
                            fontFamily: 'Lobster',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white
                          ))
                      )),

                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                      child: SizedBox(
                        //how big the picture should and the card itself
                          height: MediaQuery.of(context).size.height* 0.065,width: MediaQuery.of(context).size.height* 0.15,
                          child: Image.asset("assets/images/eddu.png") //<- here should be logik to change the picture
                      )
                      )
                      ),

                   Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(150),
                          border: Border.all(width: 2, color: Colors.white),
                          ),
                        //how big the picture should and the card itself
                          height: MediaQuery.of(context).size.height* 0.04,width: MediaQuery.of(context).size.height* 0.05,
                          child: Icon(Icons.group, color: quiz.quizIsShared ? right : wrong,), //<- here should be logik to change the picture
                      )),
                  ]),
                //middle part of the card where the picture and describtion is stackede
                Stack(children: [
                  // discribtion
                  Center(child: Padding(
                      //is for that the text and the picture dont overlape
                      //change the possition of the text
                  padding: const EdgeInsets.fromLTRB(1, 5, 10, 5),
                          //where the text shoul be
                          child: Align(alignment: Alignment.topLeft,
                          //text content
                          child:Container(
                              decoration: const BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                              )
                              ),
                              child: Text(quiz.quizDescription,style: const TextStyle(fontFamily: 'Lobster',fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20,
                          ))
                  )
                      ),
                    ),
                  ),
                ]),
                //Bottom Text and Botton
                Row(
                  //here are the bottons i have to create my own one because the ones we have arent working with the hero fuktion.
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    //where the bottom text should be
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.26,
                        child: ElevatedButton(
                          onPressed: () {},                                         //<----here for changing the quiz
                          style: ElevatedButton.styleFrom(
                            primary:  const Color (0xFFFF9800),
                            shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          ),
                              ), child:const Padding(
                                  padding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 0.0),
                                  child: Text(
                            '     Change Quiz',
                                  style: TextStyle(fontFamily: 'Lobster',fontSize: 13),
                            ),
                          ),
                        ),
                      )
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.26,
                        child: ElevatedButton(
                          onPressed: () {},                                         //<-here for joining the quiz
                          style: ElevatedButton.styleFrom(
                          primary:  const Color (0xFFFF9800),
                          shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        ),
                          ), child:const Padding(
                              padding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 0.0),
                              child: Text(
                              'Join Quiz',
                              style: TextStyle(fontFamily: 'Lobster',fontSize: 13),
                        ),
                      ),
                    ),
                  )
              ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.26,
                        child: ElevatedButton(
                          onPressed:() =>
                          Navigator.pushReplacementNamed(context, '/quizWrapper', arguments:
                          {'quiz': quiz},),
                          style: ElevatedButton.styleFrom(
                          primary:  const Color (0xFFFF9800),
                          shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        ),
                          ),child:const Padding(
                            padding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 0.0),
                            child: Text(
                            'Play Quiz',
                            style: TextStyle(fontFamily: 'Lobster',fontSize: 13),
                        ),
                      ),
                    ),
                  )
                ),
              ]),

          ])))
      )));
  }}





//when you click on the first card this second card is oppened.
//____________________________________________________________
const String _heroAddTodo = 'add-todo-hero';
class _PopupCard extends StatefulWidget {
  const _PopupCard({Key? key, required this.quiz}) : super(key:key);
  final Quiz quiz;
  @override
  State<_PopupCard> createState() => _PopupCardState();
}

class _PopupCardState extends State<_PopupCard> {
  @override
  Widget build(BuildContext context) {
    @override
    String backPickture = widget.quiz.quizCategory;
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(70.0, 25.0, 25.0, 70.0),
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
              elevation: 8.0,
              clipBehavior: Clip.antiAlias,
              //set the distance between the card and the phone border
              //change the corners of the app
              //so its circular
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
              ),
              child: Container(
                decoration: BoxDecoration(
                image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(image(backPickture)))),
                child: Padding(
                  // the distance between the contetent of the card and the corder of the card
                  padding: const EdgeInsets.all(14.0),
                  //Content of the card
                  child: Column(
                    children: [
                        //Title and Shared Icon
                    Stack(children:[
                      Padding(padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                        child: Container(
                        decoration: BoxDecoration(
                        color: Colors.teal.shade500,
                        borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                        )
                        ),
                          child: Text(widget.quiz.quizTitle,
                            style: const TextStyle(
                              fontFamily: 'Lobster',
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white
                                  )
                                )
                              )
                            ),

                      Align(
                        alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(150),
                            border: Border.all(width: 2, color: Colors.white)),
                            height: MediaQuery.of(context).size.height* 0.04,width: MediaQuery.of(context).size.height* 0.05,
                            child: Icon(Icons.group, color: widget.quiz.quizIsShared ? right : wrong,), //<- here should be logik to change the picture
                              )
                          ),
                        ]),
                        //middle part of the card where the picture and describtion is stackede
                      Stack(children: [
                        Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height* 0.15,width: MediaQuery.of(context).size.height* 0.13,
                            child: Image.asset("assets/images/eddu.png", ) //<- here should be logik to change the picture
                          )
                          ),
                            // discribtion
                        Align(
                          alignment: Alignment.topLeft,
                          child:
                          Padding(
                            //is for that the text and the picture dont overlape
                            //change the possition of the text
                                padding: const EdgeInsets.fromLTRB(1, 10, 70, 10),
                                child:Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black45,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                  )
                                  ),
                                  child: Container(
                                    child:Text(widget.quiz.quizDescription,style:
                                      const TextStyle(
                                        fontFamily: 'Lobster',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                      )
                                      ),
                                    )
                                  )
                                ),
                              ),
                            ]),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          child: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 70.0, 1.0, 5.0),
                            child: Column(children:[

                            const Text("Information:"),
                              const Text("Number of Question:"),

                              Container(
                              width: 100,
                              height: 100,
                                child: ListView.builder(
                                itemCount: widget.quiz.tags.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(children:[
                                    Container(
                                    decoration: BoxDecoration(
                                    border: Border.all(color: Colors.redAccent, width: 3.0),
                                    borderRadius: const BorderRadius.all(Radius.circular(20.0))),
                                      child: Text(widget.quiz.tags[index], style: const TextStyle(fontFamily: 'Lobster',fontSize: 15,backgroundColor: Colors.white38))
                                              )]
                                            );
                                          }
                                      )
                                    )
                                  ]
                                )
                              )
                            ),
                          ),
                        //Bottom Text and Botton
                    SizedBox(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                        child: ElevatedButton(
                        onPressed: () {},                          //<----here for changing the quiz
                        style: ElevatedButton.styleFrom(
                          primary:  const Color (0xFFFF9800),
                          shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                          child:const Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                            child: Text('Change Quiz', style: TextStyle(fontFamily: 'Lobster',fontSize: 13),),
                          ),
                        ),
                      )
                    ),
                        Align(
                        alignment: Alignment.topLeft,
                          child: Container(
                          width: MediaQuery.of(context).size.width * 0.20,
                          child: ElevatedButton(
                          onPressed:() =>
                          Navigator.pushReplacementNamed(context, '/quizWrapper', arguments: {'quiz': widget.quiz},),
                          style: ElevatedButton.styleFrom(
                          primary:  const Color (0xFFFF9800),
                          shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                              ),
                            ),
                          ),
                            child:const Padding(
                              padding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                              child: Text('Join Quiz', style: TextStyle(fontFamily: 'Lobster',fontSize: 13),),
                            )
                          )
                          )
                        ),
                        Align(
                        alignment: Alignment.bottomLeft,
                          child: Container(width: MediaQuery.of(context).size.width * 0.20,
                            child: ElevatedButton(onPressed: () {},                                 //<-here for joining the quiz
                            style: ElevatedButton.styleFrom(
                            primary:  const Color (0xFFFF9800),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20),),),
                            ),
                            child:const Padding(padding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                            child: Text('Play Quiz', style: TextStyle(fontFamily: 'Lobster',fontSize: 13),),
                                          ),
                                        ),
                                      )
                                  ),
                                ]
                            )
                        ),
                        //Back botton
                    SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Align(
                       alignment: Alignment.topCenter,
                        child: Container(
                        width: MediaQuery.of(context).size.width * 0.20,
                        child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                        primary:  const Color (0xFFFF9800),
                        shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                  child:const Padding(padding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                                  child: Text('Back', style: TextStyle(fontFamily: 'Lobster',fontSize: 13),
                                  ),
                                ),
                                ),
                              )
                          ),
                          ]
                        )
                        ),
                        //Quiz owner
                        Align(
                        child: SizedBox(
                          child: Align(
                          alignment: Alignment.topLeft,
                             child: Container(
                              decoration: BoxDecoration(
                                color: Colors.teal.shade500,
                                borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                                   )
                               ),
                               child: Text("The Owner of the quiz is: "+widget.quiz.quizOwner,
                                style: const TextStyle(
                                  fontFamily: 'Lobster',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white
                                 ),
                               ),
                             )
                            )
                        ),
                      )
                      ]
                  ),
                ),
              )
          ),
        ),
      )
      );
  }}