// ~ This will be an object based on the data from database
class Quiz {
  String quizCategory;
  String quizTitle;
  String quizOwner;
  String quizDescription;
  bool quizIsShared;

  Quiz({required this.quizCategory, required this.quizTitle, required this.quizOwner, required this.quizDescription, required this.quizIsShared});
}
