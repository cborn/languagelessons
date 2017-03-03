package languagelessons

import grails.transaction.Transactional
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder

@Transactional
class StudentService {

    def addToCourse(String courseName) {
        def result = [:]
        def fail = { Map m ->
            result.error = [ code: m.code, args: [""] ]
            return result
        }
        
        courseName = courseName.substring(0,1).toUpperCase() + courseName.substring(1);
        
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String loginUsername = authentication.getName();
        Student student = SecUser.findByUsername(loginUsername).student;
        Course course = Course.findByName(courseName);
        
        if (course.students.find { it.id ==  student.id} != null) {
            return fail(code: "enrollFail");
        } else {
            course.addToStudents(student).save()
            student.addToCourses(course).save()
        }
        return result;
    }
}
