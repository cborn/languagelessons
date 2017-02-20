package languagelessons

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

class StudentController {

@Secured(["ROLE_ADMIN"])
    def courseList() {
        [courses:Course.listOrderByName()]
    }

@Secured(["ROLE_ADMIN"])
    def index() {
        SecUser userInfo = SecUser.findById(springSecurityService.principal.id);
        redirect(controller:"admin", action:"index") // This need changing
    }
}
