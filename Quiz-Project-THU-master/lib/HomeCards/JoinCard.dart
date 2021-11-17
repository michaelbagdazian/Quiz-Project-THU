import 'package:flutter/material.dart';

class JoinCard extends StatelessWidget {

  String accountName = '';
  String accountEmail = '';
  String avatar = '';


  @override
  //Card template
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(40.0, 16.0, 40.0, 5.0),


      //change the corners of the app
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 8.0),

              //for the titel text of the card
              Text(
                  "JOIN A QUIZ",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'RobotoMono-Italic-VariableFont_wght.ttf',
                      color: Colors.blueAccent
                  )
              ),
              //the immage + botton section of the card
              SizedBox(width: 435,
                height: 210,

                //the immage + botton section of the card
                child: IconButton(
                  onPressed: () {}, //<- here you can change the destination of the card
                  icon: Image.asset("assets/images/education.jpg"), // <- immage of the card
                ),
              ),

              //Bottom text of the card
              SizedBox(height: 10,),
              Column(children: [
                Text('JOIN A QUIZ'),
                Text('PLAY WITH OTHER PLAYERS')
              ])

            ]
        ),
      ),
    );
  }



  void selectedItem(BuildContext context, String index) {
    Navigator.pushReplacementNamed(context, '/$index', arguments: {
      'accountName': accountName,
      'accountEmail': accountEmail,
      'avatar': avatar,
    });
  }
}