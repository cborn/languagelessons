package languagelessons

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

class StudentController {
    
    transient springSecurityService
    

@Secured(["ROLE_ADMIN"])
    def courseList() {
        [courses:Course.listOrderByName()]
    }

@Secured(["ROLE_ADMIN"])
    def index() {
        
       if (isLoggedIn()) {
         SecUser userInfo = SecUser.findById(springSecurityService.principal.id);
                 println(userInfo.faculty);
      }        
        // redirect(controller:"admin", action:"index") // This need changing
    }
}
