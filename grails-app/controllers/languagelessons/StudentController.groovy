package languagelessons

import grails.plugin.springsecurity.SpringSecurityUtils;
import grails.plugin.springsecurity.annotation.Secured;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.authentication.AnonymousAuthenticationToken

class StudentController {

@Secured(["ROLE_FACULTY", "ROLE_STUDENT"])
    def index() { 
        //  render 'you have ROLE_ADMIN';
        
        [courses:Course.listOrderByName()]
    }
    
    def addCourse(String courseName) {
        courseName = courseName.substring(0,1).toUpperCase() + courseName.substring(1);
        
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String loginUsername = authentication.getName();
        User curUser = User.findByUsername(loginUsername);
        
        if(curUser.isStudent) {
            def course = Course.findByName(courseName)
            def stu = curUser.student
            course.addToStudents(stu).save()
            stu.addToCourses(course).save()
        }
        
        redirect(controller:"Student",action:"index");

    }
}
