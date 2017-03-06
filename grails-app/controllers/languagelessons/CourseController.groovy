package languagelessons
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import java.text.SimpleDateFormat

// This class should have as much code as possible removed from it
// Business logic should be moved to services where possible
// Do all of these pages belong in the course controller? 

class CourseController {
    
    def courseService
    
    static scaffold = Course
    
    @Secured(["ROLE_STUDENT"])
    def studentCourseView() {
        [courses:getAuthenticatedUser().student.courses]
    }
    
    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
    def facultyCourseView() {
        [courses:getAuthenticatedUser().faculty.courses]
    }
    
    @Secured(["ROLE_FACULTY", "ROLE_ADMIN", "ROLE_STUDENT"])
    def listCourses() {
        SecUser userInfo = getAuthenticatedUser()
        [courses:Course.list(), userInfo:userInfo, faculty:userInfo.faculty, student:userInfo.student]
    }
    
    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
    def newCourse() {
        
    }
    
    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
    def create() {
        courseService.createCourse(params)
        redirect(action:"facultyCourseView")
    }
    
    def viewCourse() {
        SecUser userInfo = getAuthenticatedUser()
        String access
        if (userInfo.isFaculty) {
            access = "faculty"
        } else if (userInfo.isStudent){
            access = "student"
        }
        Course course = Course.findBySyllabusId(params.syllabusId)
        def allLessons = course.lessons.sort {it.dueDate}
        def lessonsToDisplay = []
        if (access == "student") {
            for (lesson in allLessons) {
                if (lesson.isOpen()) {
                    lessonsToDisplay.add(lesson)
                }
            }
        } else {
            lessonsToDisplay = allLessons
        }
        def allAssignments = course.assignments.sort {it.dueDate}
        def assignmentsToDisplay = []
        if (access == "student"){
            for (assignment in allAssignments) {
                if (assignment.isOpen()) {
                    assignmentsToDisplay.add(assignment)
                }
            }
        } else {
            assignmentsToDisplay = allAssignments;
        }
        def days = [:]
        def dayKeys = []
        for (lesson in lessonsToDisplay){
            if (!(lesson.dueDate.format("dd-MM-yyyy") in days)) {
                days[lesson.dueDate.format("dd-MM-yyyy")] = [lesson]
            }
            else {
                days[lesson.dueDate.format("dd-MM-yyyy")].add(lesson)
            }
        }
        for (assignment in assignmentsToDisplay){
            if (!(assignment.dueDate.format("dd-MM-yyyy") in days)) {
                days[assignment.dueDate.format("dd-MM-yyyy")] = [assignment]
            }
            else {
                days[assignment.dueDate.format("dd-MM-yyyy")].add(assignment)
            }
        }
        [course: course, access: access, days: days]
    }
}
