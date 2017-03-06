package languagelessons

import grails.transaction.Transactional
import grails.web.servlet.mvc.GrailsParameterMap
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder

@Transactional
class CourseService {

    def createCourse(GrailsParameterMap params) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Faculty faculty = SecUser.findByUsername(authentication.getName()).faculty;
        
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
            
        } else {
            //user is admin, tbd
        }
    }
}
