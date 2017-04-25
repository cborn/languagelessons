package languagelessons

abstract class QuestionResult {
    //should add an answer of appropriate type
    int pointsAwarded;
    String status;
    Question question;
    static belongsTo = [result: AssignmentResult]
    static constraints = {
    }
}
