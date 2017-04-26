package languagelessons

import org.apache.commons.codec.digest.HmacUtils

class OauthController {

    static allowedMethods = [authorize:'POST']
    
    def authorize() {
//        for(String s:request.getHeaderNames())
//            println s + ": " + request.getHeader(s)
         
        println "First name: " + params.lis_person_name_given
        println "Last Name: " + params.lis_person_name_family
        println "Email: " + params.lis_person_contact_email_primary
        println "ID: " + params.user_id
        println "Roles: " + params.roles
        println "Key: " + params.oauth_consumer_key
        println "Method: " + params.oauth_signature_method
        println "Timestamp: " + params.oauth_timestamp
        println "System Time: " + new Date(System.currentTimeMillis()).getTime()
        println "Nonce: " + params.oauth_nonce
        println "Version: " + params.oauth_version
        println "Sig: " + params.oauth_signature
        println "Callback: " + params.oauth_callback
//        println "\n" + request.XML
//        println "\n" + request.getServletURI()

//        def studentUser = new SecUser(username: 'joe@test.com', password: 'password', enabled: 'true').save()
//           Student s1 = new Student(firstName:"Joe",surname:"Mearman",studentId: 1111, email:"joe@test.com",institution:"Second Rate University").save(failOnError:true);
//           UserRole.create studentUser, studentRole
//           studentUser.student = s1
//           studentUser.save()
        
        def people = []
        people << [firstName:'John', lastName:'Doe']
        people << [firstName:'Jane', lastName:'Williams']
        render people as grails.converters.XML
    }
}
