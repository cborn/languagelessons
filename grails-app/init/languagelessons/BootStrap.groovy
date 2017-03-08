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
           def adminUser = new SecUser(username:"andrew@test.com", password: 'password', isFaculty: 'true', isStudent: 'false', enabled: 'true').save(failOnError:true);
           Faculty a1 = new Faculty(title: 'Dr', firstName: 'Andrew', surname: 'Smith',email:"andrew@test.com",university:"University of Liverpool").save()
           UserRole.create adminUser, adminRole
           adminUser.faculty = a1;
           adminUser.save()
        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
//        // Test Faculty User  %%%%%%%%%%%%%%%%%//
           def facultyUser1 = new SecUser(username: 'lee@test.com', password: 'password', isFaculty: 'true', isStudent: 'false', enabled: 'true').save()
           Faculty f1 = new Faculty(title:"Dr",firstName:"Lee",surname:"Willams",email:"lee@test.com",university:"Some University").save(failOnError:true);
           UserRole.create facultyUser1, facultyRole
           facultyUser1.faculty = f1
           facultyUser1.save()
//        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

//        // Test Faculty User  %%%%%%%%%%%%%%%%%//
           def facultyUser2 = new SecUser(username: 'jane@test.com', password: 'password', isFaculty: 'true', isStudent: 'false', enabled: 'true').save()
           Faculty f2 = new Faculty(title:"Prof",firstName:"Jane",surname:"Smith",email:"jane@test.com",university:"Second University").save(failOnError:true);
           UserRole.create facultyUser2, facultyRole
           facultyUser2.faculty = f2
           facultyUser2.save()
//        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
//        // Test Student User  %%%%%%%%%%%%%%%%%//
           def studentUser = new SecUser(username: 'joe@test.com', password: 'password', enabled: 'true').save()
           Student s1 = new Student(firstName:"Joe",surname:"Mearman",studentId: 1111, email:"joe@test.com",university:"Second Rate University").save(failOnError:true);
           UserRole.create studentUser, studentRole
           studentUser.student = s1
           studentUser.save()
          //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
          //Create Test Assignment
          
          //monty python style
          def assign1 = new Assignment(name:"Quiz 1",
                                       assignmentId: 12,
                                       introText: "Please take this quiz for Monday.",
                                       openDate: Date.parse("yyyy-mm-dd", "2016-01-01"), 
                                       dueDate: Date.parse("yyyy-mm-dd", "2016-01-05"),
                                       maxAttempts: 4)
          
          def q1 = new MultipleChoiceQuestion(pointValue: 4,
                                              question: "What is your name?",
                                              view: "multipleChoice",
                                              questionNum: 1,
                                              answers: ["Will", "Joe", "Todd"],
                                              correctAnswer: 0)
          def q2 = new MultipleChoiceQuestion(pointValue: 4,
                                              question: "What is your favorite color?",
                                              view: "multipleChoice",
                                              questionNum: 2,
                                              answers: ["Red", "Green", "Blue"],
                                              correctAnswer: 2)
          def q3 = new MultipleChoiceQuestion(pointValue: 4,
                                              question: "What is the airspeed of an unladen swallow?",
                                              view: "multipleChoice",
                                              questionNum: 3,
                                              answers: ["What? I don't know that.", "African or European?"],
                                              correctAnswer: 1)
          assign1
            .addToQuestions(q1)
            .addToQuestions(q2)
            .addToQuestions(q3)
//        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
        // Create Test Courses
            
        
        // Create Test Course and add faculty memeber
            Date start = Date.parse("yyyy-MM-dd", "2016-01-01");
            Date end = Date.parse("yyyy-MM-dd", "2017-01-01");
            new Course(name: 'Arabic', syllabusId: '1111', applicantCap: 15, startDate: start, endDate: end)
                .addToFaculty(f1)
                .addToStudents(s1) //addTo___ also supports creating the object inline
                .addToLessons(name: "Read Chapter 5",openDate: Date.parse("yyyy-mm-dd", "2016-01-01"), dueDate: Date.parse("yyyy-mm-dd", "2016-01-05"))
                .addToAssignments(assign1)
                .save(failOnError: true)

            new Course(name: 'Chinese', syllabusId: '2222', applicantCap: 20, startDate: start, endDate: end)
                .addToFaculty(f2)
                .save(failOnError: true)
            
            new Course(name: 'French', syllabusId: '3333', applicantCap: 25, startDate: start, endDate: end)
                .addToFaculty(f2)
                .save(failOnError: true)
        

    UserRole.withSession {
         it.flush()
         it.clear()
      }
      

    }
 
    //TODO: Need to write a Bootstrap test, to see if data has been added correctly.

    def destroy = {
    }
  }
