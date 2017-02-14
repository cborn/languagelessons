package languagelessons

import grails.util.Environment
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import org.hibernate.criterion.CriteriaSpecification
import grails.web.mapping.LinkGenerator
import java.text.SimpleDateFormat
import grails.converters.JSON

class BootStrap { 
    

    def init = { servletContext ->
        
// Config service add when booting system        
//        if(AppConfiguration.findAll().size() == 0)
//        {
//            AppConfiguration.createAndInsertFor("Language Lessons","The job application system",true);
//        }
//        else{
//            AppConfiguration.instance = AppConfiguration.findAll().get(0);
//        }
        
        def adminRole = new Role(authority: 'ROLE_ADMIN').save()
        def facultyRole = new Role(authority: 'ROLE_FACULTY').save()
        def studentRole = new Role(authority: 'ROLE_STUDENT').save()
        
        
        
        // Test Admin User  %%%%%%%%%%%%%%%%%//
           def adminUser = new User(username: 'andrew@test.com', password: 'password', isFaculty: 'true', isStudent: 'false', enabled: 'true').save()
           UserRole.create adminUser, adminRole
        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
        // Test Faculty User  %%%%%%%%%%%%%%%%%//
           def facultyUser = new User(username: 'lee@test.com', password: 'password', isFaculty: 'true', isStudent: 'false', enabled: 'true').save()
           UserRole.create facultyUser, facultyRole
        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
        // Test Student User  %%%%%%%%%%%%%%%%%//
           def studentUser = new User(username: 'joe@test.com', password: 'password', enabled: 'true').save()
           UserRole.create studentUser, studentRole
        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
        // Create Test Courses
            Date start = new Date();
            start.parse("yyyy-MM-dd", "2016-01-01");
            Date end = new Date();
            end.parse("yyyy-MM-dd", "2017-01-01");
            
            def Arabic = new Course(name: 'Arabic', syllabusId: '1111', applicantCap: 15, startDate: start, endDate: end).save(failOnError: true)
            def Chinese = new Course(name: 'Chinese', syllabusId: '2222', applicantCap: 20, startDate: start, endDate: end).save(failOnError: true)
            def French = new Course(name: 'French', syllabusId: '3333', applicantCap: 25, startDate: start, endDate: end).save(failOnError: true)
        

                    
UserRole.withSession {
         it.flush()
         it.clear()
      }
        
    }

    def destroy = {
    }
  }
