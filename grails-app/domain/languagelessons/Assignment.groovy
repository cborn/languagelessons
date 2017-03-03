package languagelessons

class Assignment {
    String name;
    int assignmentId;
    String introText;
    Boolean isArchived = false;
    
    Date openDate;
    Date dueDate;
    
    Boolean orderedQuestions = false;
    int maxAttempts;
    String gradeType = "points";
    static hasMany = [questions:Question];
    static belongsTo = [Course];
    def results = []
    static constraints = {
        isArchived nullable: true
        orderedQuestions nullable: true
        questions nullable: true
        gradeType nullable: true
        results nullable: true
    }
    boolean isOpen(){
        Date now = new Date()
        return now.after(openDate)
    }
}
