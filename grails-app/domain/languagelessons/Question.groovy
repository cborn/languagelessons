package languagelessons

abstract class Question {
    int pointValue;
    String question;
    String view;
    int questionNum;
    static belongsTo = Assignment;
}
