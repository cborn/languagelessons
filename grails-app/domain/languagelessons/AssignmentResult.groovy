package languagelessons

class AssignmentResult {
    int score
    int maxScore
    int potentialPoints
    Student student
    
    static hasMany = [results: QuestionResult]
    static belongsTo = [assignment: Assignment]
    
    static constraints = {
    }
}
