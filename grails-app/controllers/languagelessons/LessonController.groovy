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
    def lessonBuilder() {
        def course = Course.findBySyllabusId(params.syllabusId)
        Lesson lesson;
        if (params.createNew) {
            if (session['currentLesson']) {
                Lesson oldLesson = Lesson.findById(session['currentLesson'].id)
                if (!oldLesson) {
                    oldLesson = session['currentLesson']
                    course.addToLessons(oldLesson)
                }
                course.save(flush: true)
            }
            lesson = new Lesson(name: "untitled lesson", openDate: Date.parse("yyyy-mm-dd", "2016-01-01"), dueDate: Date.parse("yyyy-mm-dd", "2016-01-05"))
            session['currentLesson'] = lesson
        } else if (params.edit) {
            if (session['currentLesson']) {
                Lesson oldLesson = Lesson.findById(session['currentLesson'].id)
                if (!oldLesson) {
                    oldLesson = session['currentLesson']
                    course.addToLessons(oldLesson)
                }
                course.save(flush: true)
            }
            lesson = Lesson.findById(params.lessonId)
            session['currentLesson'] = lesson
        } else {
            if (session['currentLesson']) {
                lesson = session['currentLesson']
            } else {
                //This should never happen from a legitimate lessonBuilder call, so:
                assert false
            }
        }
        [html: lesson.text, user: getAuthenticatedUser(), lessonId: lesson.id, syllabusId: params.syllabusId]
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
            saveLesson.isDraft = false
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
        Lesson lesson;
        for (each in course.lessons) {
            if (each.name == params.lessonName) {
                lesson = each;
                break;
            }
        }
        assert (course != null)
        assert (lesson != null)
        [course: course, lesson: lesson]
    }
    
    def voiceLesson() {
        
    }
}
