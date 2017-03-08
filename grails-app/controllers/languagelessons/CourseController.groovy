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
            flash.message = "Cloned from "+AppConfiguration.instance.courseName+": " + clonedCourse.name + " " + clonedCourse.startDate[Calendar.YEAR] + " (" + clonedCourse.syllabusId + ")";
            
            params.managerSelect = clonedCourse.faculty;
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
       
        
        [managerList:managerList,questionList:questionList]
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
    @Secured(["ROLE_MANAGER","ROLE_ADMIN"])
    def editSingle() {
        
        SecUser userInfo = SecUser.findById(springSecurityService.principal.id);
        
        // TODO: get only questions and manager lists for items not already associated to the course
        
        def managerList = Manager.findAll();
        def countryList = Country.findAll();
        def questionList = Questions.findAllByArchivedOrArchived(null,false);
        
        def thisCourse = Course.findById(params.id);
        
        def thisDir = [];
        def courseQuestionList = [];
        if(thisCourse != null)
        {  
            thisDir = SecUser.findByManager(thisCourse.directors);
            
            if(!thisCourse.questions.isEmpty())
                courseQuestionList = Questions.findAllByIdInList(thisCourse.questions?.id);
        }
       
        // if manager, only let them edit the courses assigned to them
        if(SpringSecurityUtils.ifAllGranted("ROLE_MANAGER")) {
            def allowedUser = false;
            for(director in thisDir) {
                if(director.manager == userInfo.manager) {
                    allowedUser = true;
                }
            }
            
            if(!allowedUser) {
                redirect(controller:"admin",action:"index")
            }
        }
        
        [course:thisCourse,countryList:countryList,managerList:managerList,directors:thisDir,questionList:questionList,courseQuestionList:courseQuestionList]
    }  
    
    @Secured(["ROLE_MANAGER","ROLE_ADMIN"])
    def show() {
        
        SecUser userInfo = SecUser.findById(springSecurityService.principal.id);
        
        def managerList = SecUser.findAllByManagerIsNotNull();
        def countryList = Country.findAll();
        def questionList =  Questions.findAllByArchivedOrArchived(null,false);
        
        def thisCourse = Course.findById(params.id);
        def thisDir = SecUser.findByManager(thisCourse.directors);
        
        def courseQuestionList = [];
        
        if(!thisCourse.questions.isEmpty())
        {
            courseQuestionList = Questions.findAllByIdInList(thisCourse.questions?.id);
        }
        // if manager, only let them edit the courses assigned to them
        if(SpringSecurityUtils.ifAllGranted("ROLE_MANAGER")) {
            def allowedUser = false;
            for(director in thisDir) {
                if(director.manager == userInfo.manager) {
                    allowedUser = true;
                }
            }
            
            if(!allowedUser) {
                redirect(controller:"admin",action:"index")
            }
        }
        
        // ENROLLMENT TAB
        def enrollmentList = GenericApplication.findAllByCourse(thisCourse);
        
        def mostRecentForm = [], decisionCount = 0, depositCount = 0, tuitionCount = 0, formCount = 0;
        // if it's a US school, use proof of health insurance too
        if(thisCourse.location.name == "United States") {
            // for each application, if they have all forms completed, work out the most recent date and add to the list
            for(sa in enrollmentList) {
                if(sa.applicantId.liabilityWaiver && sa.applicantId.userPermission && sa.applicantId.proofOfInsurance) {
                    mostRecentForm.add([sa.applicantId.liabilityWaiver,sa.applicantId.userPermission,sa.applicantId.proofOfInsurance].max());
                    formCount++;
                }
                else {
                    // fill in the blanks so we can iterate over the list in the gsp to match the table rowsusing [i]
                    mostRecentForm.add("-");
                }
            }
        }
        // otherwise, just liability waiver and user permission
        else {
            // for each application, if they have all forms completed, work out the most recent date and add to the list
            for(sa in enrollmentList) {
                if(sa.applicantId.liabilityWaiver && sa.applicantId.userPermission) {
                    mostRecentForm.add([sa.applicantId.liabilityWaiver,sa.applicantId.userPermission].max());
                    formCount++;
                }
                else {
                    // fill in the blanks so we can iterate over the list in the gsp to match the table rowsusing [i]
                    mostRecentForm.add("-");
                }
            }
        }
        
        for(sa in enrollmentList) {
            if(sa.applicationDecision) {
                decisionCount++;
            }
            if(sa.tuition.depositPaid) {
                depositCount++;
            }
            if(sa.tuition.tuitionPaid) {
                tuitionCount++;
            }
        }
        
        [course:thisCourse,countryList:countryList,managerList:managerList,directors:thisDir,questionList:questionList,
            courseQuestionList:courseQuestionList,enrollmentList:enrollmentList,mostRecentForm:mostRecentForm,
            decisionCount:decisionCount,depositCount:depositCount,tuitionCount:tuitionCount,formCount:formCount]
    }
    
    @Secured(["ROLE_MANAGER","ROLE_ADMIN"])
    def processEditCourse() {
        
        // get the course
        Course thisCourse = Course.get(params.id);
        
        // set general properties
        if(params.courseName) {
            thisCourse.setName(params.courseName);
        }
        if(params.courseType) {
            thisCourse.setType(params.courseType);
        }
        if(params.courseDescription) {
            thisCourse.setDescription(params.courseDescription);
        }
        if(params.courseDeposit) {
            thisCourse.setDeposit(Float.parseFloat(params.courseDeposit));
        }
        if(params.courseCost) {
            thisCourse.setCost(Float.parseFloat(params.courseCost));
        }
        if(params.courseCap) {
            thisCourse.setApplicantCap(Integer.parseInt(params.courseCap));
        }
        if(params.hospName) {
            thisCourse.setNearestHospital(params.hospName);
        }
        if(params.hospLat) {
            thisCourse.nearestHospitalGpsLat = new java.math.BigDecimal(params.hospLat);
        }
        if(params.hospLong) {
            thisCourse.nearestHospitalGpsLong = new java.math.BigDecimal(params.hospLong);
        }
        
        // deal with the checkboxes TODO NOT WORKING
        if(params.referenceRequired == "on") {
            thisCourse.setReferenceRequired(true);
        }
        else {
            thisCourse.setReferenceRequired(false);
        }
        if(params.interviewRequired == "on") {
            thisCourse.setInterviewRequired(true);
        }
        else {
            thisCourse.setInterviewRequired(false);
        }
        if(params.recommendationRequired == "on") {
            thisCourse.setRecommendationRequired(true);
        }
        else {
            thisCourse.setRecommendationRequired(false);
        }
        if(params.transcriptRequired == "on") {
            thisCourse.setTranscriptRequired(true);
        }
        else {
            thisCourse.setTranscriptRequired(false);
        }
        if(params.acceptingApplications == "on") {
            thisCourse.setAcceptingApplications(true);
        }
        else {
            thisCourse.setAcceptingApplications(false);
        }
        
        // get the country
        if(params.countrySelect) {
            def courseCountry = Country.get(params.countrySelect);
            thisCourse.setLocation(courseCountry);
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
            thisCourse.setSyllabusId(generateSyllabusId(thisCourse.name,thisCourse.location,params.courseStartDate));
        }
        
        // add or remove the questions
        //
        def currentQuestions = Questions.getAll(thisCourse.questions?.id);  // find out what questions currently assigned
        def keepQuestion;
        for(question in currentQuestions) {
          
                thisCourse.removeFromQuestions(Questions.findById(question.id));    // remove it
            
        }
        // add after removing so we don't delete what we just added!
        for(question in params.list("questionSelect")) {
            thisCourse.addToQuestions(Questions.findById(question));
        }
        
        // add or remove the manager
        //
        def currentManager = Manager.getAll(thisCourse.directors?.id);  // find out what manager currently assigned
        def checkedManager = params.list('managerBox');  // get list of manager ticked. this will return only the selected checkboxes
        def selectedManager = Manager.getAll(checkedManager)
        def keepManager;
        for(manager in currentManager) {
           
                thisCourse.removeFromDirectors(Manager.findById(manager.id));    // remove it
           
        }
        // add after removing so we don't delete what we just added!
        for(manager in params.list("managerSelect")) {
           def f = Manager.findById(manager);
            if(f != null)
            {
                 thisCourse.addToDirectors(f);
            }
        }
        
        thisCourse.save(failOnError:true);
        flash.message = "Course updated";
        
        // if manager, send them to the 'show course' page
        if(SpringSecurityUtils.ifAllGranted("ROLE_MANAGER")) {
            redirect(action:"show",id:thisCourse.id)// TODO manager can't do this - need a fix
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