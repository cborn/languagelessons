package languagelessons

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityService

class AdminController {
    
    transient springSecurityService

    def index() { 

        SecUser userInfo = getAuthenticatedUser()

        render(view:"index", model:[userInfo:userInfo])
    }
}
