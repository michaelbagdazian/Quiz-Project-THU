import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/navigationBar/NavBar.dart';
import 'package:crew_brew/screens/quizes/quiz_list.dart';
import 'package:flutter/material.dart';
import 'package:crew_brew/services/auth.dart';
import 'package:crew_brew/services/database.dart';
import 'package:provider/provider.dart';
// ignore_for_file: file_names, non_constant_identifier_names


class quiz_Search extends StatefulWidget implements PreferredSizeWidget{
  var  title;
  @override
  _quiz_Search  createState() => _quiz_Search ();

  quiz_Search ({Key? key, required this.title}) : super(key: key);
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _quiz_Search  extends State<quiz_Search > {
  Icon cusIcon = Icon(Icons.search);
  String searchInput = "";

  @override
  Widget build(BuildContext context){
    return AppBar(
          title: widget.title,
          actions: <Widget>
          [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (this.cusIcon.icon == Icons.search) {
                      this.cusIcon = Icon(Icons.cancel);
                      widget.title = TextField(
                        // ~ This replaces the button on the keyboard of the device
                          textInputAction: TextInputAction.go,
                          // ~ When 'go' button is pressed, current widget is informed about state change
                          onSubmitted: (text) =>
                              setState(() => searchInput = text),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ));
                    } else {
                      this.searchInput = "";
                      this.cusIcon = Icon(Icons.search);
                      widget.title = Text("Quiz App");
                    }
                  });
                },
                icon: cusIcon)
          ]
      );



  }


}