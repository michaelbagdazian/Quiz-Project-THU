// import 'package:flutter/material.dart';
// import 'package:test_pro/quiz/quiz.dart';
// import 'package:test_pro/quiz/quiz_card.dart';
// import 'package:test_pro/nagivation/NavBar.dart';

// class myQuizes extends StatefulWidget {
//   const myQuizes({Key? key}) : super(key: key);

//   @override
//   _myQuizesState createState() => _myQuizesState();
// }

// class _myQuizesState extends State<myQuizes> {
//   // ~ This is how we define instances of class object
//   List<Quiz> quizes = [];

//   Map data = {};

//   @override
//   Widget build(BuildContext context) {
//     // ~ Fetch the data passed from NavBar
//     data = ModalRoute.of(context)!.settings.arguments as Map;
//     String accountName = data['accountName'];
//     String accountEmail = data['accountEmail'];
//     String avatar = data['avatar'];

//     if (quizes.isEmpty) {
//       quizes = [
//         // Quiz(author: accountName, quizName: 'Quiz 1'),
//         // Quiz(author: accountName, quizName: 'Quiz 2'),
//         // Quiz(author: accountName, quizName: 'Quiz 3'),
//         // Quiz(author: accountName, quizName: 'Quiz 4'),
//         // Quiz(author: accountName, quizName: 'Quiz 5'),
//       ];
//     }

//     return Scaffold(
//         drawer: NavBar(
//           accountName: accountName,
//           accountEmail: accountEmail,
//           avatar: avatar,
//         ),
//         backgroundColor: Colors.grey[900],
//         appBar: AppBar(
//           title: Text('My Quizes'),
//           centerTitle: true,
//           backgroundColor: Colors.grey[850],
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               // ~ Now we say map through the quiz and for each quiz I want you to get new instance of
//               // ~ QuizCard
//               children: quizes
//                   .map((quiz) => QuizCard(
//                       quiz: quiz,
//                       // ~ Here we define a delete function for each QuizCard instance
//                       delete: () {
//                         setState(() {
//                           quizes.remove(quiz);
//                         });
//                       }))
//                   .toList(),
//             ),
//           ),
//         ));
//   }
// }
