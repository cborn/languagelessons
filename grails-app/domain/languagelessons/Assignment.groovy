package languagelessons

class Assignment {
    String name;
    int assignmentId;
    String introText;
    Boolean isArchived = false;
    Boolean isDraft = true;
    Lesson lesson;
    Date openDate;
    Date dueDate;
    String html;
    
    Boolean newFormat = false;
    Boolean orderedQuestions = false;
    int maxAttempts;
    String gradeType = "points";
    
    static hasMany = [questions:Question, results: AssignmentResult]; 
    static belongsTo = Lesson;
    static mapping = {
        text sqlType: 'longText'
    }
    static constraints = {
        html nullable: true
        introText nullable: true
        isArchived nullable: true
        lesson nullable: true
        openDate nullable: true
        dueDate nullable: true
        orderedQuestions nullable: true
        questions nullable: true
        gradeType nullable: true
        assignmentId nullable: true
        results nullable: true
    }
    
    boolean isOpen(){
        Date now = new Date()
        return now.after(openDate)
    }
}
