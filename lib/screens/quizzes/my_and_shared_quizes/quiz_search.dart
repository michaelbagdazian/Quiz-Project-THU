import 'package:flutter/material.dart';
import 'package:crew_brew/shared/colors.dart';
// ignore_for_file: file_names, non_constant_identifier_names

class QuizSearch extends StatefulWidget implements PreferredSizeWidget {
  var title;
  @override
  _QuizSearch createState() => _QuizSearch();

  QuizSearch({Key? key, required this.title}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _QuizSearch extends State<QuizSearch> {
  Icon cusIcon = const Icon(Icons.search);
  String searchInput = "";

  @override
  Widget build(BuildContext context) {
    return AppBar(title: widget.title, actions: <Widget>[
      IconButton(
          onPressed: () {
            setState(() {
              if (cusIcon.icon == Icons.search) {
                cusIcon = const Icon(Icons.cancel);
                widget.title = TextField(
                    // ~ This replaces the button on the keyboard of the device
                    textInputAction: TextInputAction.go,
                    // ~ When 'go' button is pressed, current widget is informed about state change
                    onSubmitted: (text) => setState(() => searchInput = text),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                    ),
                    style: const TextStyle(
                      color: texts,
                      fontSize: 16.0,
                    ));
              } else {
                searchInput = "";
                cusIcon = const Icon(Icons.search);
                widget.title = const Text("Quiz App");
              }
            });
          },
          icon: cusIcon)
    ]);
  }
}
