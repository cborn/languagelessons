package languagelessons

import grails.plugin.springsecurity.SpringSecurityUtils;
import grails.plugin.springsecurity.annotation.Secured;

class StudentController {
    
    transient springSecurityService
    def studentService
    

    @Secured(["ROLE_ADMIN", "ROLE_FACULTY", "ROLE_STUDENT"])
    def index() { 
        
       // verify applicant and go to correct user homepage
        if (isLoggedIn()) {
            
            SecUser userInfo = SecUser.findById(springSecurityService.principal.id);
            def studentInfo;
            
            // if a applicant, go to their personal homepage
            if(SpringSecurityUtils.ifAllGranted("ROLE_STUDENT")) {
                // if this is their first time logging in, take them to enter details
                if(!userInfo.student) {
                    
                    render(view:"onFirstLogin", model:[userInfo:userInfo])
                }
                else {
                    studentInfo = userInfo.student;
			
                    [userInfo:userInfo,studentInfo:studentInfo]
                }
            }
            // if admin/manager, send them to their own homepage
            else if(SpringSecurityUtils.ifAllGranted("ROLE_FACULTY")) {
                redirect(controller:"admin", action:"index")
            }
            else if(SpringSecurityUtils.ifAllGranted("ROLE_ADMIN")) {
                redirect(controller:"admin", action:"index")
            }
        }
        else {
            redirect(uri: "/")   // return to site index
        }
    }
	
        /*if (isLoggedIn()) {
            SecUser userInfo = SecUser.findById(springSecurityService.principal.id);
            println(userInfo.faculty);
        }*/        
      // redirect(controller:"admin", action:"index") // This need changing
        
      //  [courses:Course.listOrderByName()]
    
@Secured(["ROLE_ADMIN", "ROLE_FACULTY", "ROLE_STUDENT"])
    def enroll() {
        def result = studentService.addToCourse(params.int("id"));
        
        if(!result.error) {
            redirect(controller:"course", action:"listCourses")
            return;
        }

        flash.message = g.message(code: result.error.code, args: result.error.args)
        redirect(controller:"course", action:"listCourses")
    }
    
    def withdraw() {
        def result = studentService.removeFromCourse(params.int("id"));
        
        if(!result.error) {
            redirect(controller:"course", action:"listCourses")
            return;
        }

        flash.message = g.message(code: result.error.code, args: result.error.args)
        redirect(controller:"course", action:"listCourses")
    }
    
    
    @Secured(["ROLE_STUDENT","ROLE_ADMIN"])
    def edit() {
        
        if (isLoggedIn()) {
            // find out who the current user is
            SecUser userInfo = SecUser.findById(springSecurityService.principal.id);
            
            def studentInfo;
            if(userInfo.isStudent) {
                // if a applicant, look to see who they are then direct them to that page only
                
                studentInfo = Student.get(userInfo.student.id);
            }
            else if(userInfo.isFaculty) {
                // if an admin, allow them to request a applicant profile by sending a param called applicantId
                if(params.studentId) {
                    studentInfo = Student.get(params.studentId);
                }
                else if(params.id) {
                    studentInfo = Student.get(params.id);
                }
                else {
                    redirect(uri: "/");
                }
            }
            else {
                redirect(uri: "/");
            }
            
            SecUser studentUserInfo = SecUser.findByStudent(studentInfo);

            // get the applicant, their applications and all related data
            if(studentInfo == null)
            {
                redirect(uri: "/")   // return to site index
            }
            else
            {

                [userInfo:userInfo,studentInfo:studentInfo,studentUserInfo:studentUserInfo]
            }
            
            
        }
        else {
            redirect(uri: "/")   // return to site index
        }
    }
}
