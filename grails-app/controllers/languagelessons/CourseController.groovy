package languagelessons
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import java.text.SimpleDateFormat

// This class should have as much code as possible removed from it
// Business logic should be moved to services where possible
// Do all of these pages belong in the course controller? 

class CourseController {
    def index() { }
    @Secured(["ROLE_STUDENT"])
    def studentCourseView() {
        SecUser userInfo = getAuthenticatedUser()
        def courses = userInfo.student.courses
        [courses:courses]
    }
    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
    def facultyCourseView() {
        SecUser userInfo = getAuthenticatedUser()
        def courses = userInfo.faculty.courses
        [courses:courses]
    }
     @Secured(["ROLE_FACULTY", "ROLE_ADMIN", "ROLE_STUDENT"])
    def listCourses(Boolean enrollFail) {
        SecUser userInfo = getAuthenticatedUser()
        Faculty faculty = userInfo.faculty
        Student student = userInfo.student
        def courses = Course.list()
        if (params.enrollFail) {
            flash.message = "You have already enrolled in this course!"
        }
        [courses:courses, userInfo:userInfo, faculty:faculty, student:student]
    }
    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
    def newCourse() {
        SecUser userInfo = getAuthenticatedUser()
        def courses = userInfo.student.courses
        [courses:courses]
    }
    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
    def create() {
        SecUser userInfo = getAuthenticatedUser()
        Faculty faculty = userInfo.faculty
        if (faculty){
            //User is a member of faculty and thus will be automatically added to the course
            String courseName = params.courseName
            String syllabusId = params.syllabusId
            int applicantCap = Integer.parseInt(params.applicantCap)
            Date start = Date.parse("yyyy-MM-dd", params.startDate)
            Date end = Date.parse("yyyy-MM-dd", params.endDate)
            Course course = new Course(name: courseName, syllabusId: syllabusId, applicantCap: applicantCap, startDate: start, endDate: end)
            course.addToFaculty(faculty)
            course.save(failOnError: true, flush: true)
            redirect(action:"facultyCourseView")
        } else {
            //user is admin, tbd
        }
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
