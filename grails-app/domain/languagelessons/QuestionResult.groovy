package languagelessons

abstract class QuestionResult {
    //should add an answer of appropriate type
    abstract def getAnswer();
    abstract def putAnswer(answer);
    byte[] audioAnswer;
    int intAnswer;
    String stringAnswer;
    int pointsAwarded;
    String status;
    Question question;
    static belongsTo = [result: AssignmentResult]
    static constraints = {
        audioAnswer nullable: true;
        intAnswer nullable: true;
        stringAnswer nullable: true;
    }
}
