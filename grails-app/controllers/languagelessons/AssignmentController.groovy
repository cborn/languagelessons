package languagelessons

class AssignmentController {

    def index() { }
    
    def viewAssignment(){
        def course = Course.findBySyllabusId(params.syllabusId)
        def assignment = Assignment.findByAssignmentId(params.assignId)
        [assignment:assignment, course: course]
    }
}
