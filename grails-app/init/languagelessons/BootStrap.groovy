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
           def adminUser = new SecUser(username: 'andrew@test.com', password: 'password', isFaculty: 'true', isStudent: 'false', enabled: 'true').save()
           UserRole.create adminUser, adminRole
        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
//        // Test Faculty User  %%%%%%%%%%%%%%%%%//
           def facultyUser1 = new SecUser(username: 'lee@test.com', password: 'password', isFaculty: 'true', isStudent: 'false', enabled: 'true').save()
           UserRole.create facultyUser1, facultyRole
           Faculty f1 = new Faculty(title:"Dr",firstName:"Lee",surname:"Willams",email:"lee@test.com",university:"Some University").save(failOnError:true);
//        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

//        // Test Faculty User  %%%%%%%%%%%%%%%%%//
           def facultyUser2 = new SecUser(username: 'jane@test.com', password: 'password', isFaculty: 'true', isStudent: 'false', enabled: 'true').save()
           UserRole.create facultyUser2, facultyRole
           Faculty f2 = new Faculty(title:"Prof",firstName:"Jane",surname:"Smith",email:"jane@test.com",university:"Second University").save(failOnError:true);
//        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
//        // Test Student User  %%%%%%%%%%%%%%%%%//
           def studentUser = new SecUser(username: 'joe@test.com', password: 'password', enabled: 'true').save()
           UserRole.create studentUser, studentRole
           Student s1 = new Student(firstName:"Joe",surname:"Mearman",email:"joe@test.com",university:"Second Rate University").save(failOnError:true);
//        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
        // Create Test Courses
            Date start = new Date();
            start.parse("yyyy-MM-dd", "2016-01-01");
            Date end = new Date();
            end.parse("yyyy-MM-dd", "2017-01-01");
            
        
        // Create Test Course and add faculty memeber
            def Arabic = new Course(name: 'Arabic', syllabusId: '1111', applicantCap: 15, startDate: start, endDate: end).save(failOnError: true)
            Arabic.addToFaculty(f1);
            Arabic.addToStudents(s1);
        
            def Chinese = new Course(name: 'Chinese', syllabusId: '2222', applicantCap: 20, startDate: start, endDate: end).save(failOnError: true)
            Arabic.addToFaculty(f1);
            Chinese.addToFaculty(f2);
            
            def French = new Course(name: 'French', syllabusId: '3333', applicantCap: 25, startDate: start, endDate: end).save(failOnError: true)
            French.addToFaculty(f2);
        

                    
UserRole.withSession {
         it.flush()
         it.clear()
      }
    }
    
    //TODO: Need to write a Bootstrap test, to see if data has been added correctly.

    def destroy = {
    }
  }
