package languagelessons
import static java.util.Calendar.*
import org.grails.gsp.GroovyPagesTemplateEngine
import grails.plugin.springsecurity.annotation.Secured

class LessonController {
    def groovyPagesTemplateEngine
    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
    def index() { 
        
    }
    
    @Secured(["ROLE_FACULTY"])
    def lessonBuilder() {
        int currentId = 2
        def course = Course.findBySyllabusId(params.syllabusId)
        def lesson = new Lesson(name: "untitled lesson",lessonId: currentId, openDate: Date.parse("yyyy-mm-dd", "2016-01-01"), dueDate: Date.parse("yyyy-mm-dd", "2016-01-05"))
        course.addToLessons(lesson).save(flush: true)
        [user: getAuthenticatedUser(), lessonId: lesson.lessonId]
    }
    def syncPreview() {
        System.out.println(params.lessonId)
        assert params.data != null;
        [data: params.data]
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
