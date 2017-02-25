package languagelessons

import grails.plugin.springsecurity.SpringSecurityUtils;
import grails.plugin.springsecurity.annotation.Secured;

class StudentController {
    
    transient springSecurityService
    def studentService
    

    @Secured(["ROLE_ADMIN", "ROLE_FACULTY", "ROLE_STUDENT"])
    def index() { 
	
        /*if (isLoggedIn()) {
            SecUser userInfo = SecUser.findById(springSecurityService.principal.id);
            println(userInfo.faculty);
        }*/        
      // redirect(controller:"admin", action:"index") // This need changing
        
        [courses:Course.listOrderByName()]
    }
    
    def addCourse(String courseName) {
        studentService.addToCourse(courseName);
        render("You have Successfully signed up for course: " + courseName);
    }
}
