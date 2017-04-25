package languagelessons

class Assignment {
    String name;
    String introText;
    Boolean isArchived = false;
    Boolean isDraft = true;
    Date openDate;
    Date dueDate;
    String html;
    byte[] audio;
    
    Boolean newFormat = false;
    Boolean orderedQuestions = false;
    int maxAttempts;
    String gradeType = "points";
    
    Assignment fromDraft(openDateNew, dueDateNew) {
        Assignment newAssignment = new Assignment(
            name: name,
            introText: introText,
            isArchived: isArchived,
            isDraft: false,
            openDate: openDateNew,
            dueDate: dueDateNew,
            html: html,
            newFormat: newFormat,
            orderedQuestions: orderedQuestions,
            maxAttempts: maxAttempts,
            gradeType: gradeType
        )
        for (question in questions) {
            newAssignment.addToQuestions(question.fromDraft())
        }
        return newAssignment
    }
    static hasMany = [questions:Question, results: AssignmentResult]; 
    static belongsTo = [course: Course, lesson:Lesson];
    static mapping = {
        html sqlType: 'longText'
    }
    static constraints = {
        html nullable: true
        audio nullable: true
        audio maxSize: 1073741824
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
