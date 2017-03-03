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
    
@Secured(["ROLE_STUDENT"])
    def enroll(String courseName) {
        def result = studentService.addToCourse(courseName);
        
        if(!result.error) {
            redirect(controller:"course", action:"listCourses")
            return;
        }

        flash.message = g.message(code: result.error.code, args: result.error.args)
        redirect(controller:"course", action:"listCourses")
    }
}
