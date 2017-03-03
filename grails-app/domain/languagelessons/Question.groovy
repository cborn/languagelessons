package languagelessons

abstract class Question {
    int pointValue;
    String question;
    String view;
    static belongsTo = Assignment;
}
