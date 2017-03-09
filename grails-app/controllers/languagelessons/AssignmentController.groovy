package languagelessons
import grails.plugin.springsecurity.annotation.Secured
class AssignmentController {

    def index() { }
    
    @Secured(["ROLE_STUDENT"])
    def viewAssignment(){
        def course = Course.findBySyllabusId(params.syllabusId)
        def assignment = Assignment.findByAssignmentId(params.assignId)
        SecUser user = getAuthenticatedUser()
        [assignment:assignment, course: course]
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
        def results = [:]
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
            results[question.questionNum] = params[Integer.toString(question.questionNum)]
        }
        assignment.addToResults(user.student.id, results)
        redirect(action = "viewAssignment")
    }
}
