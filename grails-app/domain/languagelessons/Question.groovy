package languagelessons

abstract class Question {
    int pointValue;
    String question;
    String view;
    int id;
    static belongsTo = Assignment;
}
