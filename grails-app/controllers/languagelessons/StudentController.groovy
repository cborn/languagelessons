package languagelessons

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

class StudentController {

@Secured(["ROLE_ADMIN"])
    def courseList() {
        [courses:Course.listOrderByName()]
    }
    
    def index() { 
        //def courses = Courses.list()
        //  render 'you have ROLE_ADMIN';
    }
}
