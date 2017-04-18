package languagelessons
import static java.util.Calendar.*
import org.grails.gsp.GroovyPagesTemplateEngine
import grails.plugin.springsecurity.annotation.Secured
import java.net.URLDecoder

class LessonController {
    def groovyPagesTemplateEngine
    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
    def index() { 
        
    }
    @Secured(["ROLE_FACULTY"])
    def viewDrafts() {
        def course = Course.findBySyllabusId(params.syllabusId)
        def lessonDrafts = []
        def lessonPushed = []
        for (lesson in course.lessons) {
            if (lesson.isDraft) {
                lessonDrafts.add(lesson)
            } else {
                lessonPushed.add(lesson)
            }
        }
        [course: course, lessons: lessonDrafts, syllabusId: params.syllabusId, pushed: lessonPushed]
    }
    def pushLesson() {
        Lesson template = Lesson.findById(params.lessonId);
        Lesson outLesson = new Lesson(name: template.name, 
                                      text: template.text, 
                                      openDate: Date.parse('yyyy-mm-dd', params.openDate),
                                      dueDate: Date.parse('yyyy-mm-dd', params.dueDate));
        outLesson.isDraft = false;
        outLesson.template = template;
        for (assignment in template.assignments) {
            outLesson.addToAssignments(assignment.fromDraft(outLesson.openDate, outLesson.dueDate))
        }
        Course course = Course.findBySyllabusId(params.syllabusId)
        course.addToLessons(outLesson)
        course.save(flush: true)
        redirect(action: "viewDraftsTable", params: [syllabusId: course.syllabusId])
    }
    def deleteLesson() {
        Lesson toDelete = Lesson.findById(params.lessonId)
        toDelete.delete(flush: true)
        redirect(action: "viewDraftsTable", params: [syllabusId: params.syllabusId])
    }
    def viewDraftsTable() {
        Course course = Course.findBySyllabusId(params.syllabusId)
        def lessonDrafts = []
        def lessonPushed = []
        for (lesson in course.lessons) {
            if (lesson.isDraft) {
                lessonDrafts.add(lesson)
            } else {
                lessonPushed.add(lesson)
            }
        }
        render(template: "viewDrafts", model: [course: course, lessons: lessonDrafts, syllabusId: params.syllabusId, pushed: lessonPushed])
    }
    @Secured(["ROLE_FACULTY"])
    def builderCreateEditHandler() {
        //doesn't do anything other make sure that the right lesson is going into lessonBuilder
        Lesson editLesson;
        if (params.createNew) {
            editLesson = new Lesson(name: 'untitled lesson')
        } else if (params.edit) {
            editLesson = Lesson.findById(params.lessonId)
        } else {
            //this should never occur through a legitimate call
            assert false;
        }
        session['currentLesson'] = editLesson;
        redirect(action: 'lessonBuilder', params: [syllabusId: params.syllabusId])
    }
    def lessonBuilder() {
        def course = Course.findBySyllabusId(params.syllabusId)
        Lesson lesson = session['currentLesson']
        [html: lesson.text, filename: lesson.name, user: getAuthenticatedUser(), lessonId: lesson.id, syllabusId: params.syllabusId]
    }
    def syncPreview() {
        def currentLesson = session['currentLesson']
        //Decodes the html from the url with java.net.URLDecoder --HTML was previously encoded in javascript script
        def html = java.net.URLDecoder.decode(params.html)
        currentLesson.text = html
        currentLesson.name = params.filename
        session['currentLesson'] = currentLesson
        [html: html]
    }
    def saveLesson() {
        def course = Course.findBySyllabusId(params.syllabusId)
        if (params.discard.trim() == 'true') {
            session['currentLesson'] = null;
        } else {
            def saveLesson = session['currentLesson']
            if (Lesson.findById(saveLesson.id)) {
                Lesson oldLesson = course.lessons.find{lesson ->  lesson.id == saveLesson.id};
                oldLesson.text = saveLesson.text
                oldLesson.name = saveLesson.name
                oldLesson.openDate = saveLesson.openDate
                oldLesson.dueDate = saveLesson.dueDate
                oldLesson.isArchived = saveLesson.isArchived
                oldLesson.isDraft = saveLesson.isDraft
                course.save(flush: true)
            } else {
                course.addToLessons(saveLesson)
                course.save(flush: true)
            }
        }
        render("saving") //This doesn't actually do anything, but grails wants it anyway
    }
    def newLesson() {
        Course course = Course.findBySyllabusId(params.syllabusId)
        [course: course]
    }
    
    def create() {
        String lessonName = params.lessonName
        String lessonText = params.lessonText
        Date open = Date.parse("yyyy-MM-dd HH:mmaa", params.openDate + " " + params.openTime)
        Date due = Date.parse("yyyy-MM-dd HH:mmaa", params.dueDate + " " + params.dueTime)
        System.out.println(due)
        Course course = Course.findBySyllabusId(params.syllabusId)
        assert (course != null)
        assert (lessonName != null)
        assert (lessonText != null)
        assert (open != null)
        assert (due != null)
        course
            .addToLessons(name: lessonName, text: lessonText, openDate: open, dueDate: due)
            .save(flush: true)
        redirect(controller: "course", action:"viewCourse", params: [syllabusId: params.syllabusId])
    }
    
    def viewLesson(){
        Course course = Course.findBySyllabusId(params.syllabusId)
        Lesson lesson = Lesson.findById(params.lessonId)
        assert (course != null)
        assert (lesson != null)
        [course: course, lesson: lesson]
    }
    
    def voiceLesson() {
        
    }
}
