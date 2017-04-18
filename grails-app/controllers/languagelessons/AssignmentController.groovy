package languagelessons
import grails.plugin.springsecurity.annotation.Secured
import groovy.json.JsonSlurper
class AssignmentController {

    def index() { }
    
    @Secured(["ROLE_FACULTY"])
    def builderCreateEditHandler() {
        //doesn't do anything other make sure that the right assignment is going into assignmentBuilder
        Assignment editAssignment;
        if (params.createNew) {
            editAssignment = new Assignment(name: 'untitled assignment')
        } else if (params.edit) {
            editAssignment = Assignment.findById(params.assignId)
        } else {
            //this should never occur through a legitimate call
            assert false;
        }
        session['current'] = editAssignment;
        redirect(action: 'assignmentBuilder', params: [syllabusId: params.syllabusId])
    }
    def assignmentView(){
        def assignment = Assignment.findById(params.assignId)
        [assignment: assignment]
    }
    def getQuestionBuild() {
        render(template: "question/" + params.templateName)
    }
    def loadQuestion() {
        //qid, assignId
        Assignment assignment = Assignment.findById(params.assignId)
        Question question = assignment.questions.find{question -> question.oldId == Long.parseLong(params.qid) }
        render(template: "question/" + question.view, model: [question: question])
    }
    def createQuestion() {
        def jsonSlurper = new JsonSlurper()
        def assignment = session['current']
        def questionData = jsonSlurper.parseText(params.questionData);
        def constructor = Question.subtypes.find {subtype -> subtype.view == questionData.type}
        Question question = constructor.construct(questionData);
        assert question != null;
        assignment.addToQuestions(question)
        session['current'] = assignment
        if (!question.save(flush: true)) {
            question.errors.allErrors.each {
                println it
            }
        }
        render(Long.toString(question.id))
    }
    def questionSelector() {
        //returns the question selector to be put into the preview
        render(template: "questionSelector", model: [options: Question.subtypes])
    }
    def addAssignmentToLesson() {
        Assignment assignment = Assignment.findById(params.assignId)
        Lesson lesson = Lesson.findById(params.lessonId)
        lesson.addToAssignments(assignment)
        lesson.save(flush: true)
        redirect(action: "viewDraftsTable", params: [syllabusId: params.syllabusId])
    }
    def deleteAssignment() {
        Assignment toDelete = Assignment.findById(params.assignId)
        assert toDelete != null
        toDelete.delete(flush: true)
        redirect(action: "viewDraftsTable", params: [syllabusId: params.syllabusId])
    }
    @Secured(["ROLE_FACULTY"])
    def viewDrafts() {
        def course = Course.findBySyllabusId(params.syllabusId)
        def lessons = course.lessons
        def assignmentDrafts = []
        def assignmentPushed = []
        for (assignment in course.assignments) {
            if (assignment.isDraft) {
                assignmentDrafts.add(assignment)
            } else {
                assignmentPushed.add(assignment)
            }
        }
        [course: course, assignments: assignmentDrafts, syllabusId: params.syllabusId, pushed: assignmentPushed]
    }
    def assignmentBuilder() {
        def course = Course.findBySyllabusId(params.syllabusId)
        Assignment assignment = session['current']
        [html: assignment.html, filename: assignment.name, user: getAuthenticatedUser(), assignmentId: assignment.id, syllabusId: params.syllabusId]
    }
    def syncPreview() {
        def currentAssignment = session['current']
        //Decodes the html from the url with java.net.URLDecoder --HTML was previously encoded in javascript script
        def html = java.net.URLDecoder.decode(params.html)
        currentAssignment.html = html
        currentAssignment.name = params.filename
        session['current'] = currentAssignment
        [html: html]
    }
    def saveAssignment() {
        def course = Course.findBySyllabusId(params.syllabusId)
        assert course != null
        if (params.discard.trim() == 'true') {
            session['current'] = null;
        } else {
            def saveAssignment = session['current']
            if (Assignment.findById(saveAssignment.id)) {
                Assignment oldAssignment = course.assignments.find{assignment ->  assignment.id == saveAssignment.id};
                oldAssignment.html = saveAssignment.html
                oldAssignment.name = saveAssignment.name
                course.save(flush: true, failOnError: true)
            } else {
                course.addToAssignments(saveAssignment)
                course.save(flush: true, failOnError: true)
            }
        }
        render("saving") //This doesn't actually do anything, but grails wants it anyway
    }
    def viewDraftsTable() {
        Course course = Course.findBySyllabusId(params.syllabusId)
        def assignmentDrafts = []
        def assignmentPushed = []
        for (assignment in course.assignments) {
            if (assignment.isDraft) {
                assignmentDrafts.add(assignment)
            } else {
                assignmentPushed.add(assignment)
            }
        }
        render(template: "viewDrafts", model: [course: course, assignments: assignmentDrafts, syllabusId: params.syllabusId, pushed: assignmentPushed])
    }
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
        def maxScore = 0
        for (question in assignment.questions) {
            //question handles all of this to allow for more compatibility
            //this will need to eventually allow for faculty review
            if (question.grade(params[Integer.toString(question.questionNum)])) {
                //answer was right
                score = score + question.pointValue
            } else {
                //answer was wrong, do something more with this later?
            }
            maxScore = maxScore + question.pointValue
            results[Integer.toString(question.questionNum)] = params[Integer.toString(question.questionNum)]
        }
        assignment
            .addToResults(studentId: student.studentId, results: results, score: score, maxScore: maxScore)
            .save(flush: true)
        redirect(controller: "lesson", 
                 action: "viewLesson", 
                 params: 
                        [syllabusId: assignment.lesson.course.syllabusId,
                         lessonName: assignment.lesson.name])
    }
}