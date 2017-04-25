package languagelessons

import grails.transaction.Transactional

@Transactional
class LessonService {

    def pushLesson(params) {
        Lesson template = params.lessonTemplate
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
    }
}
