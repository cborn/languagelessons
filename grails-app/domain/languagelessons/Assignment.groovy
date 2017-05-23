package languagelessons

class Assignment {
    String name;
    String introText;
    /*All assignments begin as drafts attached to the overarching course,
     * until they are attached to a lesson and their associated lessons is
     * pushed to the course. At this point, a duplicate assignment (using 
     * the fromDraft() method) is created, which is no longer a draft and
     * is given the openDate and dueDate of its parent lesson.*/
    Boolean isArchived = false;
    Boolean isDraft = true;
    /* Assignment openDate and closeDate are the same as their associated lesson dates,
     * or null if the assignment is not currently attached to a Lesson
     */
    Date openDate;
    Date dueDate;
    /*The assignment's appearance is dictated by its html*/
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
    /* Assignments have many questions, which are unique to that assignment.
     * They also have many AssignmentResults, which are unique to students.
     * AssignmentResults have many QuestionResults, which are unique to students
     * and to their parent questions and contain the answers of the students.
     **/
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
