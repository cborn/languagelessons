package languagelessons

import grails.transaction.Transactional
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder

@Transactional
class StudentService {

    def addToCourse(String courseName) {
        courseName = courseName.substring(0,1).toUpperCase() + courseName.substring(1);
        
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String loginUsername = authentication.getName();
        SecUser curUser = SecUser.findByUsername(loginUsername);
        
        if(curUser.isStudent) {
            def course = Course.findByName(courseName)
            def stu = curUser.student
            course.addToStudents(stu).save()
            //System.out.println(stu);
            //stu.addToCourses(course).save()
        }
    }
}
