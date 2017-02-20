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
            
            Role applicantRole = Role.findByAuthority('ROLE_STUDENT');
            applicantRole.save(flush: true, failOnError:true);
            
            UserRole.create userInfo, applicantRole;

            // Email Applicant needs seting up
            mailService.sendMail {
            async true
                to params.email;
                from "****" //This needs changing to a setting
                subject "Welcome " + params.email +". Thank you for registering on the Language Lessons";
                html g.render(template: "/templates/registration", model:[email:params.email,link:link,key:key])
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
}
