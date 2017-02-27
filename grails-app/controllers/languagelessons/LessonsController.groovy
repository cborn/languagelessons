package languagelessons
import static java.util.Calendar.*

class LessonsController {

    def index() { }
    def newLesson() {
        Course course = Course.findBySyllabusId(params.syllabusId)
        [course: course]
    }
    def create() {
        Course course = Course.findBySyllabusId(params.syllabusId)
        String lessonName = params.lessonName
        String lessonText = params.text
        Date open = new Date()
        open.parse("yyyy-MM-dd", params.openDate)
        Date due = new Date()
        due.parse("yyyy-MM-dd", params.dueDate)
        course.save(flush:true)
        Lesson lesson = new Lesson(name: lessonName, text: lessonText, openDate: open, dueDate: due)
        lesson.save(flush: true)
        course.addToLessons(lesson)
        course.save(flush:true, failOnError: true)
        redirect(controller: "course", action:"viewCourse", params: [syllabusId: params.syllabusId])
    }
}
