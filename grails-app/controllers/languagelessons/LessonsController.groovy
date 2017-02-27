package languagelessons
import static java.util.Calendar.*

class LessonsController {

    def index() { }
    def newLesson() {
        Course course = Course.findBySyllabusId(params.syllabusId)
        [course: course]
    }
    def create() {
        String lessonName = params.lessonName
        String lessonText = params.lessonText
        Date open = new Date()
        open.parse("yyyy-MM-dd", params.openDate)
        Date due = new Date()
        due.parse("yyyy-MM-dd", params.dueDate)
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
}
