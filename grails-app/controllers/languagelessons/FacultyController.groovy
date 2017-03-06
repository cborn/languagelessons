package languagelessons

import grails.plugin.springsecurity.annotation.Secured

class FacultyController {

    @Secured(["ROLE_ADMIN"])
    def index() {
        
        def allFaculty = SecUser.findAllByFacultyIsNotNull();
        
        [allFaculty:allFaculty]
    }
    
    @Secured(["ROLE_FACULTY","ROLE_ADMIN"])
    def show() {
        
        def thisFaculty = SecUser.findByFaculty(Faculty.findById(params.id));
        
        [thisFaculty:thisFaculty]
    }
}
