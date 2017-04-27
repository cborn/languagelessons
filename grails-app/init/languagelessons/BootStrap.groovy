package languagelessons

import grails.util.Environment
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import org.hibernate.criterion.CriteriaSpecification
import grails.web.mapping.LinkGenerator
import java.text.SimpleDateFormat
import grails.converters.JSON

class BootStrap { 
    def lessonService

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
           Faculty a1 = new Faculty(title: 'Dr', firstName: 'Andrew', surname: 'Smith',email:"andrew@test.com",institution:"University of Liverpool").save()
           UserRole.create adminUser, adminRole
           adminUser.faculty = a1;
           adminUser.save()
        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
//        // Test Faculty User  %%%%%%%%%%%%%%%%%//
           def facultyUser1 = new SecUser(username: 'lee@test.com', password: 'password', isFaculty: 'true', isStudent: 'false', enabled: 'true').save()
           Faculty f1 = new Faculty(title:"Dr",firstName:"Lee",surname:"Willams",email:"lee@test.com",institution:"Some University").save(failOnError:true);
           UserRole.create facultyUser1, facultyRole
           facultyUser1.faculty = f1
           facultyUser1.save()
//        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

//        // Test Faculty User  %%%%%%%%%%%%%%%%%//
           def facultyUser2 = new SecUser(username: 'jane@test.com', password: 'password', isFaculty: 'true', isStudent: 'false', enabled: 'true').save()
           Faculty f2 = new Faculty(title:"Prof",firstName:"Jane",surname:"Smith",email:"jane@test.com",institution:"Second University").save(failOnError:true);
           UserRole.create facultyUser2, facultyRole
           facultyUser2.faculty = f2
           facultyUser2.save()
//        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
//        // Test Student User  %%%%%%%%%%%%%%%%%//
           def studentUser = new SecUser(username: 'joe@test.com', password: 'password', enabled: 'true').save()
           Student s1 = new Student(firstName:"Joe",surname:"Mearman",studentId: 1111, email:"joe@test.com",institution:"Second Rate University").save(failOnError:true);
           UserRole.create studentUser, studentRole
           studentUser.student = s1
           studentUser.save()
          //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
          
          // Create Test Course and add faculty memer
            //Setting up a lesson for the first course
            Date start = Date.parse("yyyy-MM-dd", "2016-01-01");
            Date end = Date.parse("yyyy-MM-dd", "2017-01-01");
            
            Course arabic = new Course(name: 'Arabic', syllabusId: '1111', applicantCap: 15, startDate: start, endDate: end)
                .addToFaculty(f1)
                .addToStudents(s1) 
                .save(failOnError: true)

            new Course(name: 'Chinese', syllabusId: '2222', applicantCap: 20, startDate: start, endDate: end)
                .addToFaculty(f2)
                .save(failOnError: true)
            
            new Course(name: 'French', syllabusId: '3333', applicantCap: 25, startDate: start, endDate: end)
                .addToFaculty(f2)
                .save(failOnError: true)
                
          //*******************************//
          //Create Test Assignment
          //Edited to fit new assignment creation style
          //monty python style
          def assign1 = new Assignment(name:"Quiz 1",
                                       introText: "Please take this quiz for Monday.",
                                       openDate: Date.parse("yyyy-mm-dd", "2016-01-01"), 
                                       dueDate: Date.parse("yyyy-mm-dd", "2016-01-05"),
                                       maxAttempts: 4)
          assign1.html = '''
<p>You will now be assessed for knowledge of Monty Python. &nbsp;</p>

<div class="question" contenteditable="false" id="1">Question with id: 1</div>

<p>Seems pretty easy so far, doesn&#39;t it? Well let&#39;s step it up.</p>

<div class="question" contenteditable="false" id="2">Question with id: 2</div>

<p>&nbsp;How are you doing now? Ready for the next question?</p>

<div class="question" contenteditable="false" id="3">Question with id: 3</div>

<p>Well done! Now submit your answers and we&#39;ll see how you did.&nbsp;</p>
        '''
          
          def q1 = new MultipleChoiceQuestion(pointValue: 4,
                                              question: "What is your name?",
                                              view: "multipleChoice",
                                              answers: ["King Arthur of the Britons", "Sir Lancelot", "Sir Robin"],
                                              correctAnswers: [true, false, false])
          def q2 = new MultipleChoiceQuestion(pointValue: 4,
                                              question: "What is your favorite color?",
                                              answers: ["Blue", "Blue wait no I mean red aaughhhhh!!!"],
                                              correctAnswers: [true, false])
          def q3 = new MultipleChoiceQuestion(pointValue: 4,
                                              question: "What is the airspeed of an unladen swallow?",
                                              answers: ["What? I don't know that.", "African or European?"],
                                              correctAnswers: [false, true])
          assign1
            .addToQuestions(q1)
            .addToQuestions(q2)
            .addToQuestions(q3)
//        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        // Create test recording assignment

        def recordingAssignment = new Assignment(name:"Quiz 2",
                                                introText: "Please take this quiz for Monday.",
                                                openDate: Date.parse("yyyy-mm-dd", "2016-01-01"),
                                                dueDate: Date.parse("yyyy-mm-dd", "2016-01-05"),
                                                maxAttempts: 4)
        recordingAssignment.html = '''\n\
<p>Record your voice using the question below. &nbsp;</p>

<div class="question" contenteditable="false" id="7">Question with id: 7</div>

'''

        def question = new RecordingQuestion(pointValue: 4,
                                            question: "Record something, dweeb.",
                                            view: "recordingQuestion",
                                            questionNum: 1,
                                            audioType: "wav")

        recordingAssignment.addToQuestions(question)

        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        // Create Lessons
        // Edited to fit new lesson creation style
        Lesson lessonTemplate1 = new Lesson(name: "Monty Python Lesson")
        lessonTemplate1.text = '''
<p>Please watch <a href="https://www.youtube.com/watch?v=AVs7QIRYsrc">Monty Python</a>\n\
in preparation for the following quiz.</p>
        '''
        lessonTemplate1.addToAssignments(assign1)
        arabic.addToLessons(lessonTemplate1)
        arabic.save(flush: true)
        def params = [lessonTemplate: lessonTemplate1,
                  openDate: "2017-4-20",
                  dueDate: "2017-6-9",
                  syllabusId: arabic.syllabusId]
        
        lessonService.pushLesson(params)
        
        Lesson lessonTemplate2 = new Lesson(name: "Recording Lesson")
        lessonTemplate2.text = '''
        <p>Please complete the attached recording assignment.</p>
        '''
        lessonTemplate2.addToAssignments(recordingAssignment)
        arabic.addToLessons(lessonTemplate2)
        arabic.save(flush:true)
        params = [lessonTemplate: lessonTemplate2,
                  openDate: "2017-4-20",
                  dueDate: "2017-6-9",
                  syllabusId: arabic.syllabusId]
        lessonService.pushLesson(params)
            

    UserRole.withSession {
         it.flush()
         it.clear()
      }
      

    }
 
    //TODO: Need to write a Bootstrap test, to see if data has been added correctly.

    def destroy = {
    }
  }
