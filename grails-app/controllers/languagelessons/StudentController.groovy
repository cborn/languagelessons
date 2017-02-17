package languagelessons

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

class StudentController {

@Secured(["ROLE_ADMIN"])
    def index() { 
        //  render 'you have ROLE_ADMIN';
        
        [courses:Course.listOrderByName()]
    }
    
    def addCourse(String course) {
        System.out.println("name: " + course);
        
        Student stu = springSecurityService.getCurrentUser()
        stu.addToCourse(course);
    }
}
