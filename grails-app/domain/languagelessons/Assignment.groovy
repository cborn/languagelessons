package languagelessons

class Assignment {
    String name;
    String introText;
    Boolean isArchived = false;
    Boolean isDraft = true;
    Date openDate;
    Date dueDate;
    String html;
    String gradebookName;
    byte[] audio;
    
    Boolean newFormat = false;
    Boolean orderedQuestions = false;
    int maxAttempts;
    String gradeType = "points";
    
    static hasMany = [questions:Question, results: AssignmentResult]; 
    static belongsTo = [course: Course, lesson:Lesson, category: GradingCategory];
    static mapping = {
        html sqlType: 'longText'
    }
    static constraints = {
        html nullable: true
        audio nullable: true
        audio maxSize: 1073741824
        category nullable: true
        course nullable: true
        gradebookName nullable: true
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
    
    boolean isOpen(){
        Date now = new Date()
        return now.after(openDate)
    }
    
    def getStudentResults(Student stu) {
        for(AssignmentResult a: results) {
            if (stu.equals(a.student)) {
                return a
            }
        }
        return null
    }
    
    def getGradebookName() {
        if(gradebookName == null) {
            return lesson.name + ": " + name
        }
        else {
            return gradebookName;
        }
    }
    
    def setGradebookName(String name) {
        gradebookName = name;
    }
}
