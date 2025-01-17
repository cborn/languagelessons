package languagelessons
import grails.plugin.springsecurity.annotation.Secured
import groovy.json.JsonSlurper
import groovy.json.JsonOutput
import java.util.Date
class AssignmentController {
    def asyncUploadService
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
        session['uploads'] = [:]
        def user = getAuthenticatedUser()
        Student student = user.student
        Faculty faculty = user.faculty
        def assignment = Assignment.findById(params.assignId)
        [assignment: assignment, syllabusId: params.syllabusId, student: student, faculty: faculty]
    }
    def playAudio() {
        AssignmentResult result = AssignmentResult.get(params.resultId)
        RecordingResult recording = result.results.find {it.id == Long.parseLong(params.questionId)}
        render("data:audio/wav;base64," + recording.encodeBase64())
    }
    def changeGrade() {
        AssignmentResult result = AssignmentResult.get(params.resultId)
        Question question = Question.get(params.questionId)
        QuestionResult questionResult = result.results.find {it.question.id == question.oldId}
        questionResult.pointsAwarded = Integer.parseInt(params.amount);
        questionResult.status = "graded"
        questionResult.save(flush: true)
        redirect(action: "getResults", params: params)
    }
    def flagForReview() {
        AssignmentResult result = AssignmentResult.get(params.resultId)
        Question question = Question.get(params.questionId)
        QuestionResult questionResult = result.results.find {it.question.id == question.oldId}
        questionResult.status = "awaitReview"
        questionResult.save(flush: true)
        redirect(action: "getResults", params: params)
    }
    def getResults() {
        AssignmentResult result = AssignmentResult.get(params.resultId)
        def data = [:]
        def keys = []
        def values = [:]
        def answers = [:]
        def points = [:]
        def stati = [:] //it's correct in latin
        for (qResult in result.results) {
            answers[qResult.question.id] = qResult.getAnswer();
            points[qResult.question.id] = qResult.pointsAwarded;
            stati[qResult.question.id] = qResult.status;
            keys.add(qResult.question.id)
        }
        values['answers'] = answers
        values['points'] = points
        values['stati'] = stati
        data['values'] = values
        data['keys'] = keys
        render(JsonOutput.toJson(data))
    }
    def getQuestionBuild() {
        render(template: "question/" + params.templateName)
    }
    def loadQuestion() {
        //qid, assignId
        Assignment assignment = Assignment.findById(params.assignId)
        Question question = assignment.questions.find{question -> question.oldId == Long.parseLong(params.qid) }
        render(template: "question/questionDisplayTemplate", model: [question: question])
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
        def assignment = Assignment.findById(params.assignId)
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
    def getComments() {
        AssignmentResult result = AssignmentResult.get(params.resultId)
        QuestionResult questionResult = result.results.find{res -> res.question.id == Long.parseLong(params.questionId)}
        assert questionResult != null
        render(template: "comment/commentThread", model: [qResult: questionResult, comments: questionResult.comments, Comment: Comment])
    }
    def postComment() {
        def type = Comment.types.find{it.view == params.type}
        Comment comment = type.newInstance(author: getAuthenticatedUser(), posted: new Date())
        comment.putComment(params.comment)
        QuestionResult qResult = QuestionResult.get(Long.parseLong(params.resultId));
        Comment parent;
        if (params.commentId != "thread") {
            parent = Comment.get(Long.parseLong(params.commentId))
            parent.addToReplies(comment)
            comment.save(flush: true)
            parent.save(flush: true)
        } else {
            qResult.addToComments(comment)
            comment.save(flush: true)
            qResult.save(flush: true)
        }
        render(template: "comment/commentThread", model: [qResult: qResult, comments: qResult.comments, Comment: Comment])
    }
    @Secured(["ROLE_STUDENT"])
    def asyncUploadHandler() {
        asyncUploadService.put(params.id, Integer.parseInt(params.index), params.element)
        render(params.index)
    }
    @Secured(["ROLE_STUDENT"])
    def submitAssignment() {
        def jsonSlurper = new JsonSlurper();
        def data = jsonSlurper.parseText(params.data);
        SecUser user = getAuthenticatedUser();
        Student student = user.student;
        Assignment assignment = Assignment.findById(data.assignment)
        AssignmentResult assignResult = new AssignmentResult(student: student);
        
        int maxScore = 0;
        int score = 0;
        int potentialPoints = 0;
        data.out.each { id, answer ->
            Question question = Question.findById(id)
            QuestionResult qResult = question.resultType.newInstance(pointsAwarded: 0, status: "awaitReview", question: question)
            if (qResult.asyncUpload) {
                answer = asyncUploadService.get(answer.toString())
            }
            qResult.putAnswer(answer)
            maxScore = maxScore + question.pointValue;
            
            if (question.requiresReview) {
                //question requires faculty review
                potentialPoints = potentialPoints + question.pointValue;
            } else {
                boolean correct = question.grade(answer)
                if (correct) {
                    qResult.pointsAwarded = question.pointValue
                    score = score + question.pointValue
                }
                qResult.status = "graded"
            }
            
            assignResult.addToResults(qResult)
        }
        assignResult.maxScore = maxScore
        assignResult.score = score
        assignment.addToResults(assignResult)
        
        if (assignment.course) {
            assignment.course.save(flush:true)
        }
        if (assignment.lesson) {
            assignment.lesson.save(flush:true)
        }
        render("done")
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