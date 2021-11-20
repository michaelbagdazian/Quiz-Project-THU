import 'package:flutter/material.dart';
import 'package:test_pro/nagivation/NavBar.dart';




class UserCard extends StatelessWidget {

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
              SizedBox(height: 5.0),

              //for the titel text of the card
              Text(
                  "USER",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'RobotoMono-Italic-VariableFont_wght.ttf',
                      color: Colors.blueAccent
                  )
              ),
              SizedBox(width: 435,
                height: 110,

                //the immage + botton section of the card
                child: IconButton(
                  onPressed: () => selectedItem(context, 'userProfile'),//<- here you can change the destination of the card
                  icon: Image.asset("assets/images/User.png"), // <- immage of the card
                ),
              ),


              //Bottom text of the card
              SizedBox(height: 10,),
              Column(children: [
              ])

            ]
        ),
      ),
    );
  }



  void selectedItem(BuildContext context, String index) {
    // ~ It works similar to pushNamed, but instead of putting home on top of userProfile, it will replace home with location
    // ~ So location will no longer exist
    Navigator.pushReplacementNamed(context, '/$index', arguments: {
      'accountName': accountName,
      'accountEmail': accountEmail,
      'avatar': avatar,
    });
  }
}