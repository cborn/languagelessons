package languagelessons

import grails.transaction.Transactional
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder

@Transactional
class StudentService {

    def addToCourse(int id) {
        def result = [:]
        def fail = { Map m ->
            result.error = [ code: m.code, args: [""] ]
            return result
        }
        
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String loginUsername = authentication.getName();
        Student student = SecUser.findByUsername(loginUsername).student;
        Course course = Course.findBySyllabusId(id);
        
        if (course.students.find { it.id ==  student.id} != null) {
            return fail(code: "enrollFail");
        } else {
            course.addToStudents(student).save()
            student.addToCourses(course).save()
        }
        return result;
    }
    
    def removeFromCourse(int id) {
        def result = [:]
        def fail = { Map m ->
            result.error = [ code: m.code, args: [""] ]
            return result
        }
        
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String loginUsername = authentication.getName();
        Student student = SecUser.findByUsername(loginUsername).student;
        Course course = Course.findBySyllabusId(id);
        
        if (course.students.find { it.id ==  student.id} == null) {
            return fail(code: "withdrawFail");
        } else {
            course.removeFromStudents(student).save()
            student.removeFromCourses(course).save()
        }
        return result;
    }
}
