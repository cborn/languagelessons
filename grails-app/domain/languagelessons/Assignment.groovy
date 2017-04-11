package languagelessons

class Assignment {
    String name;
    String introText;
    Boolean isArchived = false;
    Boolean isDraft = true;
    Date openDate;
    Date dueDate;
    String html;
    
    Boolean newFormat = false;
    Boolean orderedQuestions = false;
    int maxAttempts;
    String gradeType = "points";
    
    static hasMany = [questions:Question, results: AssignmentResult]; 
    static belongsTo = [course: Course, lesson:Lesson];
    static mapping = {
        text sqlType: 'longText'
    }
    static constraints = {
        html nullable: true
        course nullable: true
        introText nullable: true
        isArchived nullable: true
        lesson nullable: true
        openDate nullable: true
        dueDate nullable: true
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
