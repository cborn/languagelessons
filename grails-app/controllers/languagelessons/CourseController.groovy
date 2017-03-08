package languagelessons
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import grails.gorm.DetachedCriteria
import java.text.SimpleDateFormat
import static java.util.Calendar.*
import org.springframework.dao.DataIntegrityViolationException

// This class should have as much code as possible removed from it
// Business logic should be moved to services where possible
// Do all of these pages belong in the course controller? 

class CourseController {
    
 //   def courseService
    
  //  static scaffold = Course
    
    @Secured(["ROLE_FACULTY","ROLE_ADMIN"])
    def index() {
        
        // All field schools
        def allCourses = Course.findAllByIsArchived("false", [max:params.max, offset:params.offset]);
        
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

        // extract the date
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
        // parse it into a simpledate
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
        def thisSeason = sdf.parse(month + "/" + dayOfMonth + "/" + year);

        // Term courses
        def seasonCourses = Course.createCriteria().list(max:params.max, offset:params.offset) {
            between("startDate", thisSeason, thisSeason+365)   
        }
        
        def results, condition;
        if(params.status == "all") {
            results = allCourses;
            condition = "All Courses";
        }
        else if(params.status == "archive") {
            results = Course.createCriteria().list(max:params.max, offset:params.offset) {
                eq("isArchived", true);
            }
            condition = "Archived Courses";
        }
        else if(params.status == "season") {
            results = seasonCourses;
            int thisSeasonYear = year + 1;
            condition = "All Courses in the " + thisSeasonYear + " Season";
        }
        else {
            results = allCourses;
            condition = "All Courses";
        }
        
        
        [courseList:results,title:condition]
    }
    
    
//    Removed Scaffolding
//    @Secured(["ROLE_STUDENT"])
//    def studentCourseView() {
//        [courses:getAuthenticatedUser().student.courses]
//    }
//    
//    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
//    def facultyCourseView() {
//        [courses:getAuthenticatedUser().faculty.courses]
//    }
//    
//    @Secured(["ROLE_FACULTY", "ROLE_ADMIN", "ROLE_STUDENT"])
//    def listCourses() {
//        SecUser userInfo = getAuthenticatedUser()
//        [courses:Course.list(), userInfo:userInfo, faculty:userInfo.faculty, student:userInfo.student]
//    }
//    
//    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
//    def newCourse() {
//        
//    }
    
//    @Secured(["ROLE_FACULTY", "ROLE_ADMIN"])
//    def create() {
//        courseService.createCourse(params)
//        redirect(action:"facultyCourseView")
//    }
    
    @Secured(["ROLE_ADMIN"])
    def create() {
        
        if(params.clone) {
            def clonedCourse = Course.findById(params.clone);
            flash.message = "Cloned from course: " + clonedCourse.name + " " + clonedCourse.startDate[Calendar.YEAR] + " (" + clonedCourse.syllabusId + ")";
            
            params.facultySelect = clonedCourse.faculty;
            params.questionSelect = clonedCourse.lessons;
            params.name = clonedCourse.name;
            params.applicantCap = clonedCourse.applicantCap;
            params.description = clonedCourse.description;
            params.startDate = clonedCourse.startDate;
            params.endDate = clonedCourse.endDate;
        }
        
        def facultyList = Faculty.findAll();
        
        // this should be: findAllByArchived(false);
        // but the param was added late so it fails under null values
        def questionList = Questions.findAllByArchivedOrArchived(null,false);
       
        
        [facultyList:facultyList,facultyList:facultyList]
    }
    
    @Secured(["ROLE_ADMIN"])
    def processAddCourse() {
        
        // create the course
        Course newCourse = new Course();
        
        // set general properties
        newCourse.setName(params.courseName);
        //newCourse.setDescription(params.courseDescription);
        newCourse.setDescription("");
        newCourse.setApplicantCap(Integer.parseInt(params.courseCap));
        
        // parse the dates
        SimpleDateFormat sdf = new SimpleDateFormat("M/dd/yyyy");
        newCourse.setStartDate(sdf.parse(params.courseStartDate));
        newCourse.setEndDate(sdf.parse(params.courseEndDate));
        // TODO CALCULATE A PAYMENT DEADLINE? (not a db field)
        
        // generate a syllabus id: first 3 chars of name, first 3 chars of country, 2 digit year, sequential char
        newCourse.setSyllabusId(generateSyllabusId(params.courseName,params.courseStartDate));
        
        // add questions
        for(question in params.list("questionSelect")) {
            newCourse.addToQuestions(Questions.findById(question));
        }
        
        // add manager
        for(faculty in params.list("facultySelect")) {
            def f = Faculty.findById(faculty);
            if(f != null)
            {
                newCourse.addToFaculty(f);
            }
        }
        
        newCourse.save(failOnError:true);
        redirect(action:"show",params:[id:newCourse.id])
    }
    
    // mass edit courses
    @Secured(["ROLE_ADMIN"])
    def editAll() {
        
        // All field schools
        def allCourses = Course.createCriteria().list(max:params.max, offset:params.offset) {
            eq("isArchived", false)
        }

        // Season field schools
        def thisYear = Calendar.instance.get(YEAR).toString();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy");    // parse the year into a date
        def thisSeason = sdf.parse(thisYear);
        def termCourses = Course.createCriteria().list(max:params.max, offset:params.offset) {
            between("startDate", thisSeason, thisSeason+365)   
        }
        
        def results, condition;
        if(params.status == "term") {
            results = termCourses;
            condition = "All Courses in the " + thisSeason[Calendar.YEAR] + " Term";
        }
        else if(params.status == "archive") {
            results = Course.createCriteria().list(max:params.max, offset:params.offset) {
                eq("isArchived", true)
            }
            condition = "Archived Courses";
        }
        else {
            results = allCourses;
            condition = "All Courses";
        }
        
        [allCourses:results,title:condition]
    }   
    
    // update the courses
    def updateCourses = { MultipleCourseUpdate command ->
        
        // update each of the form items called "courses[i].fieldname" 
        command.courses.each { c ->             // call each one 'c' duting the loop
            Course course = Course.get(c.id);   // get the course with the same id as the one we're looking at from params
            course.properties = c.properties;   // if any of the names match, update those
            course.save();                      // save the record
        }
        
        redirect(action:"editAll", params:[status:params.status]);
    }
    
    // edit individual courses, TODO let manager update their own course?
    @Secured(["ROLE_FACULTY","ROLE_ADMIN"])
    def editSingle() {
        
        SecUser userInfo = getAuthenticatedUser();
        
        // TODO: get only questions and manager lists for items not already associated to the course
        
        def facultyList = Faculty.findAll();
        def lessonList = Lesson.findAllByArchivedOrArchived(null,false);
        
        def thisCourse = Course.findById(params.id);
        
        def thisDir = [];
        def courseQuestionList = [];
        if(thisCourse != null)
        {  
            thisDir = SecUser.findByFaculty(thisCourse.faculty);
            
            if(!thisCourse.lessons.isEmpty())
                courseLessonList = Lesson.findAllByIdInList(thisCourse.lessons?.id);
        }
       
        // if manager, only let them edit the courses assigned to them
        if(SpringSecurityUtils.ifAllGranted("ROLE_FACULTY")) {
            def allowedUser = false;
            for(faculty in thisDir) {
                if(facutly.faculty == userInfo.faculty) {
                    allowedUser = true;
                }
            }
            
            if(!allowedUser) {
                redirect(controller:"admin",action:"index")
            }
        }
        
        [course:thisCourse,facultyList:facultyList,faculty:thisDir,lessonList:lessonList,courseLessonList:courseLessonList]
    }  
    
    @Secured(["ROLE_FACULTY","ROLE_ADMIN"])
    def show() {
        
        SecUser userInfo = getAuthenticatedUser();
        
        def facultyList = SecUser.findAllByFacultyIsNotNull();
        def lessonList =  Lesson.findAllByIsArchivedOrIsArchived(null,false);
        
        def thisCourse = Course.findById(params.id);
        def thisDir = SecUser.findByFaculty(thisCourse.faculty);
        
        def courseLessonList = [];
        
        if(!thisCourse.lessons.isEmpty())
        {
            courseLessonList = Lessons.findAllByIdInList(thisCourse.lessons?.id);
        }
        // if manager, only let them edit the courses assigned to them
        if(SpringSecurityUtils.ifAllGranted("ROLE_FACULTY")) {
            def allowedUser = false;
            for(faculty in thisDir) {
                if(faculty.faculty == userInfo.faculty) {
                    allowedUser = true;
                }
            }
            
            if(!allowedUser) {
                redirect(controller:"admin",action:"index")
            }
        }
        
        // ENROLLMENT TAB
       // def enrollmentList = GenericApplication.findAllByCourse(thisCourse);
        
        
        [course:thisCourse,facultyList:facultyList,faculty:thisDir,lessonList:lessonList,
            courseLessonList:courseLessonList]
    }
    
        @Secured(["ROLE_ADMIN"])
    def archive() {
        
        def thisCourse = Course.get(params.id);
        
        thisCourse.setIsArchived(true);
        thisCourse.setAcceptingApplications(false);
        
        // redirect to edit page
        flash.message = "Course archived";
        redirect(action:"editAll");
    }
    
    @Secured(["ROLE_ADMIN"])
    def unarchive() {
        
        def thisCourse = Course.get(params.id);
        
        thisCourse.setIsArchived(false);
        // don't automatically open it though
        
        // redirect to edit page
        flash.message = "Course unarchived";
        redirect(action:"editAll");
    }
    
    @Secured(["ROLE_ADMIN"])
    def archiveAll() {
        
        // get the current season
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        def thisTerm = sdf.parse(Calendar.instance.get(YEAR).toString());
        
        // find all non-archived courses from previous seasons
        def coursesToArchive = Course.createCriteria().list() {//max:params.max, offset:params.offset) {
            lt("startDate", thisTerm-365)
            eq("isArchived", false)
        }
        
        // archive them
        for(course in coursesToArchive) {
            course.setIsArchived(true);
        }
        
        // redirect to edit page
        flash.message = "All Courses from previous seasons have been archived (modified ${coursesToArchive.size()} Courses)";
        redirect(action:"index", params:[status:params.status]);
    }
    
    @Secured(["ROLE_ADMIN"])
    def list() {
        
        // modify this to change how many are shown in index pages
        //def maxShownOnIndex = 10;

        // if no max or offset sent, use 10 and 0 by default
        //params.max = params.max ?: maxShownOnIndex
        //params.offset = params.offset ?: 0
        
        def results;
        
        if(params.querySelect == "c") {
            // the '%' means there can be attached chars here
            if(params.fieldSelect == "cn") {
                results = Course.createCriteria().list() {//max:params.max, offset:params.offset) {
                    ilike("name", '%'+params.searchTerms+'%')
                }
            }
            else if(params.fieldSelect == "sid") {
                results = Course.createCriteria().list() {//max:params.max, offset:params.offset) {
                    ilike("syllabusId", '%'+params.searchTerms+'%')
                }
            }
            else if(params.fieldSelect == "dn") {
                results = Course.createCriteria().list() {//max:params.max, offset:params.offset) {
                    directors {
                        or {
                            ilike("firstName", '%'+params.searchTerms+'%')
                            ilike("surname", '%'+params.searchTerms+'%')
                        }
                    }
                }
            }
            else if(params.fieldSelect == "co") {
                results = Course.createCriteria().list() {//max:params.max, offset:params.offset) {
                    location {
                        ilike("name", '%'+params.searchTerms+'%')
                    }
                }
            }
        }
        
        if(params.querySelect == "bw") {
            // the '%' means there can be attached chars here
            if(params.fieldSelect == "cn") {
                results = Course.createCriteria().list() {//max:params.max, offset:params.offset) {
                    ilike("name", params.searchTerms+'%')
                }
            }
            else if(params.fieldSelect == "sid") {
                results = Course.createCriteria().list() {//max:params.max, offset:params.offset) {
                    ilike("syllabusId", params.searchTerms+'%')
                }
            }
            else if(params.fieldSelect == "dn") {
                results = Course.createCriteria().list() {//max:params.max, offset:params.offset) {
                    directors {
                        or {
                            ilike("firstName", params.searchTerms+'%')
                            ilike("surname", params.searchTerms+'%')
                        }
                    }
                }
            }
            else if(params.fieldSelect == "co") {
                results = Course.createCriteria().list() {//max:params.max, offset:params.offset) {
                    location {
                        ilike("name", params.searchTerms+'%')
                    }
                }
            }
        }
        
        [params:params,results:results]
    }
    
    @Secured(["ROLE_FACULTY","ROLE_ADMIN"])
    def processEditCourse() {
        
        // get the course
        Course thisCourse = Course.get(params.id);
        
        // set general properties
        if(params.courseName) {
            thisCourse.setName(params.courseName);
        }
        if(params.courseDescription) {
            thisCourse.setDescription(params.courseDescription);
        }
        
        // parse the dates
        SimpleDateFormat sdf = new SimpleDateFormat("M/dd/yyyy");
        if(params.courseStartDate) {
            thisCourse.setStartDate(sdf.parse(params.courseStartDate));
        }
        if(params.courseStartDate) {
            thisCourse.setEndDate(sdf.parse(params.courseEndDate));
        }
        
        // TODO let them edit the syllabus ID?
        if(params.courseSyllabusId) {
            thisCourse.setSyllabusId(params.courseSyllabusId);
        }
        
        // if blank autogenerate a new id
        if(params.generateNewSyllabusId == "on") {
            // generate a syllabus id: first 3 chars of name, first 3 chars of country, 2 digit year, sequential char
            thisCourse.setSyllabusId(generateSyllabusId(thisCourse.name,params.courseStartDate));
        }
        
        // add or remove the questions
        //
        def currentLessons = Lessons.getAll(thisCourse.lessons?.id);  // find out what questions currently assigned
        def keepQuestion;
        for(lesson in currentLessons) {
          
                thisCourse.removeFromLessons(Lessons.findById(lesson.id));    // remove it
            
        }
        // add after removing so we don't delete what we just added!
        for(lesson in params.list("lessonSelect")) {
            thisCourse.addToLessons(Lessons.findById(lesson));
        }
        
        // add or remove the manager
        //
        def currentFaculty = Faculty.getAll(thisCourse.faculty?.id);  // find out what manager currently assigned
        def checkedFaculty = params.list('facultyBox');  // get list of manager ticked. this will return only the selected checkboxes
        def selectedFaculty = Faculty.getAll(checkedFaculty)
        def keepFaculty;
        for(faculty in currentFaculty) {
           
                thisCourse.removeFromFaculty(Faculty.findById(faculty.id));    // remove it
           
        }
        // add after removing so we don't delete what we just added!
        for(faculty in params.list("facultySelect")) {
           def f = Faculty.findById(faculty);
            if(f != null)
            {
                 thisCourse.addToFaculty(f);
            }
        }
        
        thisCourse.save(failOnError:true);
        flash.message = "Course updated";
        
        // if manager, send them to the 'show course' page
        if(SpringSecurityUtils.ifAllGranted("ROLE_FACULTY")) {
            redirect(action:"show",id:thisCourse.id)// TODO Faculty can't do this - need a fix
        }
        else {
            redirect(action:"editSingle",id:params.id);
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

// how each course must be updated
class SingleCourseUpdate {
    // the id
    Integer id;
    
    // list each thing to be updated
    String name;
    String syllabusId;
    Integer applicantCap;
}

// all courses are updated by calling the single course update function
class MultipleCourseUpdate {
    List<SingleCourseUpdate> courses = [].withDefault({ new SingleCourseUpdate() });
}