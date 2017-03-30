package languagelessons
import static java.util.Calendar.*
import org.grails.gsp.GroovyPagesTemplateEngine
class LessonController {
    def groovyPagesTemplateEngine
    def index() { 
        
    }
    
    def lessonBuilder() {
        // Place holder for text editing system
        
    }
    def syncPreview() {
        System.out.println("I am working, at least.")
        //def compiledContent = templateEngine.createTemplate(params.data, 'view')
        //render(template: "syncPreview", model)
        
        //def output = new StringWriter()
        //groovyPagesTemplateEngine.createTemplate(params.data, idgen).make([show: true, items: ['Grails','Groovy']]).writeTo(output)
        render params.data
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
