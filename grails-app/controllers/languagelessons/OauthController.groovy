package languagelessons

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.web.authentication.WebAuthenticationDetails
import org.springframework.security.core.Authentication


class OauthController {

    static allowedMethods = [authorize:'POST']
    
    def ltiService
    
    def authorize() {
        
        def xmlMap = request.getParameterMap()
        TreeMap<String,String> fullMap = new TreeMap<String,String>();
        
        for(String key: xmlMap.keySet()) {
            for(String value: xmlMap.get(key)) {
               fullMap.put(key, value)
//               println key + ": " + value
            }
        }
        
        println fullMap.get("roles")
        
        ltiService.decideUserRole(fullMap.get("roles"))
        
        String sig = LtiService.generateOAuthSignature("POST", request.getRequestURL().toString(), "my-secret", fullMap)
                
        if(sig.equals(params.oauth_signature)) {
            if(SecUser.findByUsername(params.lis_person_contact_email_primary) == null) {
                ltiService.createMoodleUser(fullMap)
            }
                
            String username = params.lis_person_contact_email_primary
            String password = ltiService.generateMoodlePassword(params.lis_person_contact_email_primary, params.lis_person_name_full)
            
            SecUser userInfo = getAuthenticatedUser();
            
            redirect(action:"login", params:[user:username, pword:password])

//            render "sick"
        }
        else{
            render sig + "\n" + params.oauth_signature
        }
    }
    
    def login () {
        params
    }
}
