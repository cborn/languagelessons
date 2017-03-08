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
        //assert (params.assignment != null);
        //['assignmentId':'12', '1':'0', '2':'2', '3':'1']
        Assignment assignment = Assignment.findByAssignmentId(params.assignmentId)
        int i = 0;
        def results = [:]
        for (question in assignment.questions) {
            //question handles all of this to allow for more compatibility
            assert params[question.questionNum] != null //this should exist, it does not currently
            if (question.grade(params[question.questionNum])) {
                //answer was right
            } else {
                //answer was wrong
            }
        }
        render params
    }
}
