package languagelessons

abstract class QuestionResult {
    //should add an answer of appropriate type
    abstract def getAnswer();
    abstract def putAnswer(answer);
    boolean asyncUpload;
    byte[] audioAnswer;
    int intAnswer;
    String stringAnswer;
    int pointsAwarded;
    String status;
    Question question;
    
    static belongsTo = [result: AssignmentResult]
    static hasMany = [comments: Comment]
    
    static constraints = {
        audioAnswer maxSize: 1073741824
        audioAnswer nullable: true;
        intAnswer nullable: true;
        stringAnswer nullable: true;
    }
}