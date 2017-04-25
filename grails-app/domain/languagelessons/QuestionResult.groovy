package languagelessons

class QuestionResult {
    def answer;
    int pointsAwarded;
    String status;
    Question question;
    static belongsTo = [result: AssignmentResult];
    
    static constraints = {
    }
}
