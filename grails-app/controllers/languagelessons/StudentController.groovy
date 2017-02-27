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
@Secured(["ROLE_STUDENT"])
    def enroll() {
        SecUser userInfo = getAuthenticatedUser()
        Student student = Student.findByEmail(userInfo.username)
        Course course = Course.findBySyllabusId(params.id)
        if (course.students.contains(student)) {
            redirect(controller: "course", action:"listCourses", params: [enrollFail: true])
        } else {
            course.addToStudents(student)
            course.save(flush: true)
            redirect(controller:"course", action:"listCourses")
        }
    }
}
