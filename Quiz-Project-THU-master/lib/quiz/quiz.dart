import 'package:flutter/cupertino.dart';

class Quiz {

  String quizName = '';
  String author = '';

  // ~ Named Parameters: defined with {} around parameters
  // ~ When we then create an object, order does not matter, because we name
  // ~ the provided parameters
  Quiz({ required this.quizName, required this.author });

}

// ~ Now we are using Named Parameters.
// Quote myquote = Quote(text: 'this is the quote text', author: 'oscar wilde');