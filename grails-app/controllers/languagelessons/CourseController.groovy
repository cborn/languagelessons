package languagelessons
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import java.text.SimpleDateFormat

class CourseController {
    static scaffold = Course

    def index() { }
    @Secured(["ROLE_STUDENT"])
    def studentCourseView() {
        SecUser userInfo = getAuthenticatedUser()
        Student student = Student.findByEmail(userInfo.username)
        def courses = Course.list().findAll {course -> course.students.contains(student)}
        [courses:courses]
    }
    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
    def facultyCourseView() {
        SecUser userInfo = getAuthenticatedUser()
        Faculty faculty = Faculty.findByEmail(userInfo.username)
        def courses = faculty.courses
        [courses:courses]
    }
     @Secured(["ROLE_FACULTY", "ROLE_ADMIN", "ROLE_STUDENT"])
    def listCourses() {
        SecUser userInfo = getAuthenticatedUser()
        Faculty faculty = Faculty.findByEmail(userInfo.username)
        Student student = Student.findByEmail(userInfo.username)
        def courses = Course.list()
        if (params.enrollFail) {
            flash.message = "You have already enrolled in this course!"
        }
        [courses:courses, userInfo:userInfo, faculty:faculty, student:student]
    }
    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
    def newCourse() {  }
    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
    def create() {
        SecUser userInfo = getAuthenticatedUser()
        Faculty faculty = Faculty.findByEmail(userInfo.username)
        if (faculty){
            //User is a member of faculty and thus will be automatically added to the course
            String courseName = params.courseName
            String syllabusId = params.syllabusId
            int applicantCap = Integer.parseInt(params.applicantCap)
            Date start = new Date()
            start.parse("yyyy-MM-dd", params.startDate)
            Date end = new Date()
            end.parse("yyyy-MM-dd", params.endDate)
            Course course = new Course(name: courseName, syllabusId: syllabusId, applicantCap: applicantCap, startDate: start, endDate: end)
            course.addToFaculty(faculty)
            course.save(failOnError: true, flush: true)
            redirect(action:"listCourses")
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
        [course: course, access: access]
    }
}
