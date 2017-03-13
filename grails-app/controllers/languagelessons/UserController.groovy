package languagelessons

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import org.hibernate.criterion.CriteriaSpecification
import grails.web.mapping.LinkGenerator
import java.text.SimpleDateFormat
import grails.converters.JSON

class UserController {
    
    transient mailService
    transient springSecurityService

    def index() { 
        render(view:"register")
    }
    
    
// This will change, when I have time to add a real search %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    @Secured(["ROLE_ADMIN"])
    def searchResults()
    {
      ArrayList<HashMap<String,Object>> results = new ArrayList<HashMap<String,Object>>();
        if(params.query != null)
        {
            results = getSearchResults(params.query);
        }
        [results:results];
    }
    
    
    
    @Secured(["ROLE_ADMIN"])
    def search(){
       ArrayList<HashMap<String,Object>> res =  getSearchResults(params.query);
        
        render res as JSON;
    }
        // find all sec users with username like
        
     public ArrayList<HashMap<String,Object>> getSearchResults(String q){
        
        
        String query = q.split(" ")[0];
        
        ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	if(query.length() > 2)
	{
        
            if(query.isNumber())
            {
                SecUser secuser = SecUser.findById(query);

                if(secuser != null && secuser.isStudent)
                {

                    Student stuu = secuser.student;

                    if(stuu.firstName != null)
                    { HashMap<String,Object> map = new HashMap<String, Object>();
                        map.put("title",stuu.firstName + " "+stuu.surname);
                        map.put("subtitle","Student");
                        map.put("url","/student/edit/"+stuu.id);
                        list.add(map);
                    }
                }
                }
        
        def su = SecUser.findAllByUsernameIlike('%'+query+'%') as Set;
        
        
        for(SecUser user : su)
        {
                
             HashMap<String,Object> map = new HashMap<String, Object>();
           
            
            if(user.isStudent && user.student)
            {
            
                Student s = user.student;
             
                    if(s.firstName != null)
                    {
                        map.put("title",s.firstName + " "+s.surname);
                    }
                    else
                    {
                        map.put("title",user.username);
                    }
                
                map.put("subtitle","Student");
                map.put("url","/student/edit/"+s.id);

             
            }
            else if(user.isFaculty && user.faculty)
            {
                
                Faculty faculty = user.faculty;
                
                if(faculty.firstName != null)
                {
                    map.put("title",faculty.firstName + " "+faculty.surname);
                    map.put("subtitle","Faculty");
                    map.put("url","/faculty/show/"+faculty.id);
                }
            }
            
            list.add(map);  
        }

        def s1 = Student.findAllByFirstNameIlike('%'+query+'%') as Set;
        def s2 = Student.findAllBySurnameIlike('%'+query+'%') as Set;
        
        
        Set u = s1 + s2;
        
             HashSet<Student> newSet = new HashSet<Student>();
            // remove dupes 
            
            
            for(Student s : u)
            {
                boolean contains = false;
                for(Student stu : newSet)
                {
                    if(s.getId() == stu.getId())
                    {
                        contains = true;
                    }
                }              
                if(!contains)
                {
                    newSet.add(s);
                }
            }

        
        def f1 = Faculty.findAllByFirstNameIlike("%"+query+"%") as Set;
        def f2 = Faculty.findAllBySurnameIlike("%"+query+"%") as Set;
        
        
        Set f = f1 + f2;        
        
            
            HashSet<Faculty> fac = new HashSet<Faculty>();
            // remove dupes 
            
            
            for(Faculty s : f)
            {
                boolean contains = false;
                for(Faculty stu : fac)
                {
                    if(s.getId() ==  stu.getId())
                    {
                        contains = true;
                    }
                }
                
                
                if(!contains)
                {
                    fac.add(s);
                }
                
                
            }
            
        
        for(Faculty faculty : fac)
        {
             HashMap<String,Object> mp = new HashMap<String, Object>();
            
                if(faculty.firstName != null)
                {  
                    mp.put("title",faculty.firstName +" "+faculty.surname + " "+faculty.surname);
                    mp.put("subtitle","faculty");
                    mp.put("url","/faculty/show/"+faculty.id);
                }
            list.add(mp);
            
            
        }
        
        
//        Can't get courses working in the search 
//        def c1 = Course.findAllByNameIlike("%"+query+"%") as Set;
//        def c2 = Course.findAllByTypeIlike("%"+query+"%") as Set;
//        
//        Set c = c1 + c2;
//        
//            HashSet<Course> cou = new HashSet<Course>();
//            // remove dupes 
//            
//            
//            for(Course s : c)
//            {
//                boolean contains = false;
//                for(Course stu : cou)
//                {
//                    if(s.getId() ==  stu.getId())
//                    {
//                        contains = true;
//                    }
//                }
//                
//                
//                if(!contains)
//                {
//                    cou.add(s);
//                }
//                
//                
//            }
//        
//        for(Course course : cou)
//        {
//           HashMap<String,Object> mp = new HashMap<String, Object>();
//            
//            if(course.name != null)
//            {
//                mp.put("title",course.name);
//                mp.put("subtitle","Course");
//                mp.put("url","/course/show/"+course.id);
//            }
//            
//            list.add(mp);  
//        }
//        
        

        
		}
        ArrayList<HashMap<String,Object>> newList = new ArrayList<HashMap<String,Object>>();
        
        for(HashMap<String,Object> mp : list)
        {
             boolean contains = false;
            for(HashMap<String,Object> mpin : newList)
            {
                if(mp.get("url") != null)
                {
                    if(mp.get("url").equalsIgnoreCase(mpin.get("url")))
                    {
                        contains = true;
                    }
                    if(mp.get("title") == "" || mp.get("title") == null )
                    {
                        contains = true;
                    }
                }
                else
                {
                    contains = true;
                }
            }
            
            if(!contains)
            {
                newList.add(mp);
            }
             
        }      
        return newList;
    }
    
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    def processRegistration() {
        
        // check details
        def allUsers = SecUser.findAll();
        def detailsOk = true;
//        def recaptchaOk = true;
        
        if(params.email) {
            for(user in allUsers) {
                if(user.username == params.email) {
                    flash.error = "Sorry, \"" + params.email + "\" is already associated to an account";
                    detailsOk = false;
                }
            }
        }
        
        if(params.password && params.passwordDuplicate) {       // if both fields completed
            if(params.password != params.passwordDuplicate) {   // if they don't match
                flash.error = "Could not complete registration: password fields do not match";
                detailsOk = false;
            }
        }
        
// Recaptcha        
//        if(!recaptchaService.verifyAnswer(session, request.getRemoteAddr(), params)) {
//            flash.error = "Could not complete registration please try again";
//            recaptchaOk = false;
//        }
        
//        SimpleDateFormat sdf = new SimpleDateFormat("M/dd/yyyy");
//        def dateOfBirth = sdf.parse(params.dateOfBirth);
//        // check dob
//        if(new Date() - dateOfBirth < 6205) { // if less than 365*17=6205 days between dob and now
//            flash.error = "Sorry, you must be over 17 to register";
//            detailsOk = false;
//        }
        
        if(detailsOk){ // Add && recaptchaOk if using recaptcha

            String key = UUID.randomUUID().toString();
            
            // Creates a unlock key
            def link = grailsLinkGenerator.serverBaseURL+"/User/unlockAccount?key="+key;
            
            // create a new user here
            SecUser userInfo = new SecUser(k: key, username: params.email, password: params.password).save(flush: true, failOnError:true);
            
            Role studentRole = Role.findByAuthority('ROLE_STUDENT');
            studenttRole.save(flush: true, failOnError:true);
            
            UserRole.create userInfo, studentRole;
            
            try {
            // Email Applicant needs seting up
            mailService.sendMail {
            async true
                to params.email;
                from "****" //This needs changing to a setting
                subject "Welcome " + params.email +". Thank you for registering on the Language Lessons";
                html g.render(template: "/templates/registration", model:[email:params.email,link:link,key:key])
                }
            } catch (Exception e) {
            log.error("Failed to send email ${params.email}", e)
            }
//            recaptchaService.cleanUp(session);
            
            render(view:"completeRegistration")
        }
        else {
            render(view:"register")
        }
    }
    
    def resetPassword(){
         render(view:"resetPassword")
    }
    
    def unlockAccount()
    {
        SecUser u = SecUser.findByK(params.key);
        
        if(!u)
        {
            flash.success = "This link has already been used to activated this account. Please try and login"
            redirect(uri: "/");
            return
        }
        
        u.enabled = true;
        u.k = null;
        
        if(!u.save(flush:true))
        {
            render "We are experiencing problems at the moment, please try again later."
            return
        }
        else
        {
            flash.error = "Success, your account has now been activated. Please login."
            redirect(uri: "/");
            return
        }
    }
    
    @Secured(["ROLE_ADMIN"])
    def list() {
        
        SecUser thisUser = SecUser.findById(springSecurityService.principal.id);
        
        def accountTypeList = ["Any":"Any","Student":"Student","Faculty":"Faculty","Administrator":"Administrator"];
        
        // modify this to change how many are shown in index pages
        //def maxShownOnIndex = 10;

        // if no max or offset sent, use 10 and 0 by default
        //params.max = params.max ?: maxShownOnIndex
        //params.offset = params.offset ?: 0
        //params.sort = params.sort ?: "username"
        //params.order = params.order ?: "asc"
        
        // allow specific user searches, e.g username, account type filters etc
        def results, resultsSize;
        
        // if an account type selected
        if(params.accountTypeSelect && !params.userSearch) {
            
            if(params.accountTypeSelect == "Any") {
                results = SecUser.list();//params);  // All Users
            }
            else if(params.accountTypeSelect == "Student") {
                results = SecUser.createCriteria().list(){//max:params.max, offset:params.offset) {
                    eq("isStudent", true)
                    //order(params.sort, params.order)
                }
            }
            else if(params.accountTypeSelect == "Faculty") {
                results = [];
                //results += UserRole.findAllByRole(Role.findByAuthority("ROLE_MANAGER"),[max:params.max, offset:params.offset]).user;
                results += UserRole.findAllByRole(Role.findByAuthority("ROLE_FACULTY")).user;
            }
            else if(params.accountTypeSelect == "Administrator") {
                results = [];
                //results += UserRole.findAllByRole(Role.findByAuthority("ROLE_ADMIN"),[max:params.max, offset:params.offset]).user;
                results += UserRole.findAllByRole(Role.findByAuthority("ROLE_ADMIN")).user;
            }
        }
        
        // if something in the user search box
        if(params.userSearch) {
            
            // if no account type specified, make it 'any'
            if(!params.accountTypeSelect || params.accountTypeSelect == "Any") {
                results = SecUser.createCriteria().list() {//max:params.max, offset:params.offset) {
                    createAlias('student', 's', CriteriaSpecification.LEFT_JOIN)
                    createAlias('faculty', 'f', CriteriaSpecification.LEFT_JOIN)
                    or {
                        ilike("username", '%'+params.userSearch+'%')
                        ilike("s.firstName", '%'+params.userSearch+'%')
                        ilike("f.firstName", '%'+params.userSearch+'%')
                        ilike("s.surname", '%'+params.userSearch+'%')
                        ilike("f.surname", '%'+params.userSearch+'%')
                    }
                    //order(params.sort, params.order)
                }
            }
            else if(params.accountTypeSelect == "Student") {
                results = SecUser.createCriteria().list() {//max:params.max, offset:params.offset) {
                    eq("isStudent", true)
                    createAlias('Student', 's', CriteriaSpecification.LEFT_JOIN)
                    or {
                        ilike("username", '%'+params.userSearch+'%')
                        ilike("s.firstName", '%'+params.userSearch+'%')
                        ilike("s.surname", '%'+params.userSearch+'%')
                    }
                    //order(params.sort, params.order)
                }
            }
            else if(params.accountTypeSelect == "Faculty" || params.accountTypeSelect == "Administrator") {
                def temp = SecUser.createCriteria().list() {//max:params.max, offset:params.offset) {
                    eq("isFaculty", true)
                    createAlias('Faculty', 'f', CriteriaSpecification.LEFT_JOIN)
                    or {
                        ilike("username", '%'+params.userSearch+'%')
                        ilike("f.firstName", '%'+params.userSearch+'%')
                        ilike("f.surname", '%'+params.userSearch+'%')
                    }
                    //order(params.sort, params.order)
                }
                
                def temp2 = [];
                
                if(params.accountTypeSelect == "Faculty") {
                    temp2 += UserRole.findAllByRole(Role.findByAuthority("ROLE_FACULTY"),[params]).user;
                }
                else if(params.accountTypeSelect == "Administrator") {
                    temp2 += UserRole.findAllByRole(Role.findByAuthority("ROLE_ADMIN"),[params]).user;
                }
                
                results = [];
                // check through each, preserving order
                for(acc in temp) {
                    for(res in temp2) {
                        if(res.id == acc.id) {
                            results += res
                        }
                    }
                }
            }
        }
        
        // if nothing searched for, show all
        if(!params.accountTypeSelect && !params.userSearch) {
            results = SecUser.list();//params);  // All Users
        }
        /*
        if(params.accountTypeSelect == "Faculty" || params.accountTypeSelect == "Administrator") {
            resultsSize = results.size();
        }
        else {
            resultsSize = results.totalCount;
        }
        */
        def resultsRoles = [];
        for(result in results) {
            resultsRoles.add(UserRole.findByUser(result).role);
        }
        /*
        render(contentType: "application/json") {
            users = array {
                for (u in results) {
                    secuser email: u.username
                    secuser name: u.getFullName()
                }
            }
        }
        */
        [results:results,resultsSize:resultsSize,accountTypeList:accountTypeList,resultsRoles:resultsRoles,thisUser:thisUser,title:"All Users"]
    }
    
  def toggleUserEnabled() {
        
        SecUser userInfo = SecUser.findById(params.id);
        
        // if they are enabled, disable them
        if(userInfo.enabled) {
            userInfo.enabled = false;
            flash.message = "User Account Disabled: " + userInfo.username;
        }
        else if(!userInfo.enabled) {
            // check theyre' allowed to be enabled
            //if(userInfo.applicant || userInfo.manager) {
                userInfo.enabled = true;
                flash.message = "User Account Enabled: " + userInfo.username;
            /*}
            else {
                flash.message = "Cannot Enable Account: " + userInfo.username;
            }*/
        }
        
        userInfo.save(failOnError:true);
        
        redirect(action:"list");
    }
    
    def delete() {
        
        SecUser userInfo = SecUser.findById(params.id);
        userInfo.lock();
        
        // delete manager and applicant
        try {
            if(userInfo.isFaculty && userInfo.faculty) {
                def facultyInfo = userInfo.faculty;
                
                // take the courses off them
                facultyInfo.courses.clear();
                
                // remove the manager account
                userInfo.faculty = null;
                userInfo.save(flush:true);
                
                // then delete manager
                facultyInfo.delete(flush:true);
            }

            if(userInfo.isStudent && userInfo.student) {
                def studentInfo = userInfo.student;
				
		if(studentInfo != null)
		{
                    // Need to delete:
                    // applicantId (applications), paymentEvents, events
                    // Should delete automatically:
                    // address, transcriptAddress, identification, primaryContact, secondaryContact, answerId
                    
                    // ... and now schollarship!!!
                    
                    // delete their applications
                    // applicantId = applications
                    def apps = [];
                    apps += studentInfo.studentId;
                    apps.each { studentId ->
                        studentInfo.removeFromStudentId(studentId);
                    }
                    
                    // delete their events and payment events

                    // remove the applicant account
                    userInfo.student = null;
                    userInfo.save(flush:true);

                    // then delete the applicant
                    studentInfo.delete(flush:true);
                }
            }
			
            // find the roles associated with this user. 
            Collection<UserRole> userRoles = UserRole.findAllByUser(userInfo);
            userRoles*.delete();
		  
            // finally delete the user
            userInfo.delete(flush:true);
            
            // other data is deleted through cascading
        }
        // TODO: check this may cause error when deleting user with multiple applications
        catch (org.springframework.dao.DataIntegrityViolationException e) {
            flash.message = "Could not delete user " + userInfo.username;
            redirect(action:"list");
        }
        
        // redirect to admin page
        flash.message = "User deleted";
        redirect(action:"list");
    }
    
    def edit() {
        
        SecUser userLoggedIn = SecUser.findById(springSecurityService.principal.id);
        SecUser userInfo = SecUser.findById(params.id);
        
        def accountTypeList = ["Student":"Student","Faculty":"Faculty","Administrator":"Administrator"];
        
        def titleList = ["Prof":"Prof.",
                        "Dr":"Dr.",
                        "Mr":"Mr.",
                        "Mrs":"Mrs.",
                        "Ms":"Ms.",
                        "None":"None",
                        "Lord":"Lord"];
        
        // put the right value in the select
        UserRole currentRole = UserRole.findByUser(userInfo);
        def currentAccountType;
        
        if(currentRole.role.toString() == "ROLE_STUDENT") { 
            currentAccountType = "Student";
        }
        else if(currentRole.role.toString() == "ROLE_FACULTY") { 
            currentAccountType = "Faculty";
        }
        else if(currentRole.role.toString() == "ROLE_ADMIN") { 
            currentAccountType = "Administrator";
        }
        
        [userLoggedIn:userLoggedIn,userInfo:userInfo,accountTypeList:accountTypeList,currentAccountType:currentAccountType,titleList:titleList]
    }
    
    def processEditUser() {
        
        SecUser userLoggedIn = SecUser.findById(springSecurityService.principal.id);
        SecUser userInfo = SecUser.findById(params.id);
        
        def allUsers = SecUser.findAll();
        def detailsOk = true;
        
        // update username
        if(params.username) {
            for(user in allUsers) {
                if(user.username == params.username) {
                    // if it's the same user, ignore; if it's someone else, stop them
                    if(userInfo.id != SecUser.findById(user.id).id) {
                        flash.error = "Could not update email: \"" + params.username + "\" is already in use";
                        detailsOk = false;
                    }
                }
            }
            if(detailsOk){
                userInfo.setUsername(params.username);
            }
        }
        
        // update roles
        UserRole userInfoRole;
        if(params.accountTypeSelect == "Student") {
            // get the role
            Role studentRole = Role.findByAuthority("ROLE_STUDENT");
            
            // remove the current userrole and replace it
            UserRole.removeAll(userInfo);
            UserRole.create(userInfo,studentRole);
            
            // edit extra data
            userInfo.faculty = null;
            userInfo.isFaculty = false;
            userInfo.isStudent = true;  // if being downgraded they will have to add applicant details on first login
            // TODO: disassociate from courses
        }
        else if(params.accountTypeSelect == "Faculty") {
            // get the role
            Role facultyRole = Role.findByAuthority("ROLE_FACULTY");
            
            // remove the current userrole and replace it
            UserRole.removeAll(userInfo);
            UserRole.create(userInfo,facultyRole);
            
            // edit extra data
            userInfo.student = null;
            if(!userInfo.faculty) {
                Faculty newFaculty = new Faculty();
            
                newFaculty.setTitle("");
                newFaculty.setFirstName("");
                newFaculty.setSurname("");
                newFaculty.setInstitution("");
                newFaculty.save(failOnError:true);

                userInfo.faculty = newFaculty;
            }
            userInfo.isFaculty = true;
            userInfo.isStudent = false;
        }
        else if(params.accountTypeSelect == "Administrator") {
            // get the role
            Role adminRole = Role.findByAuthority("ROLE_ADMIN");
            
            // remove the current userrole and replace it
            UserRole.removeAll(userInfo);
            UserRole.create(userInfo,adminRole);
            
            // edit extra data
            userInfo.student = null;
            if(!userInfo.faculty) {
                Faculty newFaculty = new Faculty();
            
                newFaculty.setTitle("");
                newFaculty.setFirstName("");
                newFaculty.setSurname("");
                newFaculty.setInstitution("");
                newFaculty.save(failOnError:true);

                userInfo.faculty = newManager;
            }
            userInfo.isFaculty = true;
            userInfo.isStudent = false;
        }
        
        // if the user logged in is looking at their own page, they can edit password
        if(userLoggedIn == userInfo) {
            if(params.password && params.passwordDuplicate) { // if both fields completed
                if(params.password == params.passwordDuplicate) { // if they match
                    // set password
                    userInfo.setPassword(params.password);
                    flash.message = "Password changed";
                }
                else {
                    flash.error = "Could not update password: fields did not match";
                    detailsOk = false;
                }
            }
            else if(params.password || params.passwordDuplicate) {
                flash.error = "Could not update password: complete both fields to update password";
                detailsOk = false;
            }
        }
        
        // update the manager info
        if(userInfo.isFaculty) {
            if(params.title) {
                userInfo.faculty.title = params.title;
            }
            if(params.firstName) {
                userInfo.faculty.firstName = params.firstName;
            }
            if(params.surname) {
                userInfo.faculty.surname = params.surname;
            }
            if(params.institution) {
                userInfo.faculty.institution = params.institution;
            }
        }
        else if(userInfo.isStudent) {
            // TODO: don't have anything here, right? They can edit it all on userinfo page
        }
        
        if(detailsOk) {
            userInfo.save(failOnError:true);
            flash.message = "User Information Updated";
        }
        
        redirect(action:"edit", params:[id:userInfo.id]);
    }
    
    def create() {
        
        def accountTypeList = ["Student":"Student","Faculty":"Faculty","Administrator":"Administrator"];
        
        def titleList = ["":"None","Prof":"Prof.",
                        "Dr":"Dr.",
                        "Mr":"Mr.",
                        "Mrs":"Mrs.",
                        "Ms":"Ms.",
                        "Lord":"Lord"];
        
        if(params.courseWorkflow) {
            def course = Course.findById(params.courseWorkflow);
            
            accountTypeList = ["Faculty":"Faculty"];    // default to manager for safety
            flash.message = "Please create a new manager account for " + course.name;
        }
        
        [accountTypeList:accountTypeList,titleList:titleList]
    }
    
    def processAddUser() {
        
        def allUsers = SecUser.findAll();
        def detailsOk = true;
        
        // check username
        for(user in allUsers) {
            if(user.username == params.username) {
                flash.error = "Could not create account: \"" + params.username + "\" is already associated with an account";
                detailsOk = false;
            }
        }
        
        if(detailsOk) {
            // create the user
            String pw = UUID.randomUUID().toString();
            SecUser userInfo = new SecUser(username:params.username,password:pw);
            
            if(params.accountTypeSelect == "Faculty" || params.accountTypeSelect == "Administrator") {
                Faculty newFaculty = new Faculty();

                newFaculty.setTitle(params.facultyTitle);
                newFaculty.setFirstName(params.facultyFirstName);
                newFaculty.setSurname(params.facultySurname);
                newFaculty.setInstitution(params.facultyInstitution);
                newFaculty.save(failOnError:true);

                userInfo.faculty = newFaculty;
                userInfo.isFaculty = true;
                userInfo.isStudent = false;
                userInfo.save(failOnError:true);

                if(params.accountTypeSelect == "Administrator") {
                    Role adminRole = Role.findByAuthority("ROLE_ADMIN");
                    UserRole.create(userInfo,adminRole);
                    
                    //Email Details
                    addedFacultyEmail(userInfo);
                    flash.message = "User Created: " + userInfo.username + ", Administrator";
                }
                else if (params.accountTypeSelect == "Faculty") {
                    Role managerRole = Role.findByAuthority("ROLE_FACULTY");
                    UserRole.create(userInfo,facultyRole);
                    
                    //Email Details
                    addedFacultyEmail(userInfo);
                    flash.message = "User Created: " + userInfo.username + ", Manager";
                }
                else {
                    Role studentRole = Role.findByAuthority("ROLE_STUDENT");
                    UserRole.create(userInfo,studentRole);
                    flash.message = "User Created: " + userInfo.username + ", Student";
                }
            }
            else if(params.accountTypeSelect == "Student") {
                Student newStudent = new Student();

                newStudent.setFirstName(params.studentFirstName);
                newStudent.setSurname(params.studentSurname);
                newStudent.save(failOnError:true);

                userInfo.student = newStudent;
                userInfo.isFaculty = false;
                userInfo.isStudent = true;
                userInfo.save(failOnError:true);

                Role studentRole = Role.findByAuthority("ROLE_STUDENT");
                UserRole.create(userInfo,studentRole);
                
                //Email Details
                addedStudentEmail(userInfo);
                flash.message = "User Created: " + userInfo.username + ", Student";
            }
            
            if(params.courseWorkflow) { // if we're making a course go back to that
                def course = Course.findById(params.courseWorkflow);
                course.setDirector(userInfo.faculty);
                
                redirect(controller:"course",action:"index")
            }
            else {
                redirect(action:"list");
            }
        }
        else {
            redirect(action:"create", params:[username:params.username,accountTypeSelect:params.accountTypeSelect,
                facultyTitle:params.facultyTitle,facultyFirstName:params.facultyFirstName,
                facultySurname:params.facultySurname,facultyInstitution:params.facultyInstitution,
                studentFirstName:params.studentFirstName,studentSurname:params.studentSurname]);
        }
    }
}
