import 'package:crew_brew/models/quiz/Quiz.dart';
import 'package:crew_brew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_tile.dart';

/// ! Information about the class:
/// ~ This class returns ListView widget to myQuizes page
/// ! Use of the class:
/// ~ Fetch Quiz data from the DB and output into the list

/// ! TODOS:
/// TODO Improve loading as done in welcome and sign_in with boolean loading variable
/// TODO If after some time fetch of the Quiz Data was not succesful, display error message

class QuizList extends StatefulWidget {
  final String searchInput;

  const QuizList({Key? key, required this.searchInput}) : super(key: key);

  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  @override
  Widget build(BuildContext context) {
    /// ! Provider.of<List<Quiz>?>(context);
    /// ~ We access the quizes from here. It's updated when some changes to the database occur
    /// ~ The provider is defined in screens/quizes/myQuizes and sharedQuizes classes
    /// ~ There are 2 streams, because this class is used for both, sharedQuizes and myQuizes ( code reusability )
    List<Quiz>? quizes = Provider.of<List<Quiz>?>(context);

    /// ! If quizes were sucessfuly fetched from the DB, return ListView
    if (quizes != null) {
      /// ! Check if there is a search entry, and then change the content of quizes list
      if (widget.searchInput != "") {
        quizes = getSearchedQuizes(widget.searchInput, quizes);
      }

      /// ! ListView.builder:
      /// ~ The ListView.builder constructor takes an IndexedWidgetBuilder, which builds the children on demand.
      return ListView.builder(
        itemCount: quizes.length,
        /// ! itemBuilder:
        /// ~ itemBuilder is the function in itself which is going to return some kind of template or a widget tree for each item inside the list
        itemBuilder: (context, index) {
          /// TODO Implement search here
          return QuizTile(quiz: quizes![index]);
        },
      );
    } else {
      return Loading();
    }
  }

  /// ! getSearchedQuizes
  /// ~ This method return list of quizes based on the search result. Search is performed on quizes title
  List<Quiz> getSearchedQuizes(String searchInput, List<Quiz>? quizes) {
    List<Quiz> searchedQuizList = [];

    if (quizes != null) {
      for (Quiz quiz in quizes) {
        if (quiz.quizTitle.toLowerCase().contains(searchInput.toLowerCase())) {
          searchedQuizList.add(quiz);
        }
      }
    }

    return searchedQuizList;
  }
}
