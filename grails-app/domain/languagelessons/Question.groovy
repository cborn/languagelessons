package languagelessons

abstract class Question {
    int pointValue;
    String question;
    String view;
    int questionNum;
    
    Boolean archived = false;
    static belongsTo = Assignment;
    
    static constraints = {
        question maxSize: 5000
        archived nullable: true
    }
}
