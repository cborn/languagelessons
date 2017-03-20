package languagelessons
import grails.plugin.springsecurity.annotation.Secured
class AssignmentController {

    def index() { }
    
    @Secured(["ROLE_STUDENT"])
    def viewAssignment(){
        def course = Course.findBySyllabusId(params.syllabusId)
        def assignment = Assignment.findByAssignmentId(params.assignId)
        SecUser user = getAuthenticatedUser()
        Student student = user.student
        def result;
        for (indr in assignment.results) {
            if (indr.studentId == student.studentId) {
                result = indr;
            }
        }
        [assignment:assignment, course: course, result: result]
    }
    @Secured(["ROLE_STUDENT"])
    def gradeAssignment() {
        //Isn't working properly right now, is called properly when you navigate
        //to the url, but can't be called by the form for some reason unless the button
        //has the name gradeAssignment
        SecUser user = getAuthenticatedUser();
        Student student = user.student;
        Assignment assignment = Assignment.findByAssignmentId(params.assignmentId)
        int i = 0;
        Map<String,String> results = [:]
        def score = 0
        for (question in assignment.questions) {
            //question handles all of this to allow for more compatibility
            //this will need to eventually allow for faculty review
            if (question.grade(params[Integer.toString(question.questionNum)])) {
                //answer was right
                score = score + question.pointValue
            } else {
                //answer was wrong, do something more with this later?
            }
            results[Integer.toString(question.questionNum)] = params[Integer.toString(question.questionNum)]
        }
        assignment
            .addToResults(studentId: student.studentId, results: results)
            .save(flush: true)
        redirect(controller: "lesson", 
                 action: "viewLesson", 
                 params: 
                        [syllabusId: assignment.lesson.course.syllabusId,
                         lessonName: assignment.lesson.name])
    }
}