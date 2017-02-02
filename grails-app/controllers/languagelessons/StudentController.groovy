package languagelessons

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

class StudentController {

@Secured(["ROLE_ADMIN"])
    def index() { 
         // render 'you have ROLE_ADMIN';
    }
}
