package languagelessons

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityService
import java.text.SimpleDateFormat
import static java.util.Calendar.*

class AdminController {
    
    transient springSecurityService

    
    @Secured(["ROLE_FACULTY","ROLE_ADMIN"])
    def index() { 
        
        if (isLoggedIn()) {
            SecUser userInfo = getAuthenticatedUser()

            // modify this to change how many are shown in index pages
            def maxShownOnIndex = 10;
            
            // if no max or offset sent, use 10 and 0 by default
            params.max = params.max ?: maxShownOnIndex
            params.offset = params.offset ?: 0
            
            // calculate the season
            // season goes from 1st October - 30th September
            
            // set the date as 1st October
            Calendar calendar = new GregorianCalendar();
            calendar.set(Calendar.MONTH, OCTOBER);
            calendar.set(Calendar.DAY_OF_MONTH, 1);
            
            // get month
            // if month jan-sept, season starts in previous year 
            if(Calendar.instance.get(MONTH) <= 8) {
                calendar.set(Calendar.YEAR, Calendar.instance.get(YEAR)-1);   // get the previous year
            }
            // if oct-dec, season is current year
            else {
                calendar.set(Calendar.YEAR, Calendar.instance.get(YEAR));   // get the current year
            }


            // All Users
            def allUsers = SecUser.list(max:params.max, offset:params.offset);

            // All faculty
            def allFaculty = SecUser.findAllByFacultyIsNotNull();

            // All courses
            def allCourses = Course.list(max:params.max, offset:params.offset);

            render(view:"index", model:[userInfo:userInfo, allUsers:allUsers, allFaculty:allFaculty, allCourses:allCourses])
        }
    }
}
