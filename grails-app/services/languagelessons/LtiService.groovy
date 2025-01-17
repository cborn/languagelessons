package languagelessons


import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec
import org.springframework.web.util.UriUtils

class LtiService {
    
    public static void createMoodleUser (Map parameters) {
        String pw = generateMoodlePassword(parameters.get("lis_person_contact_email_primary"), parameters.get("lis_person_name_full"))
        
        String usertype = decideUserRole(parameters.get("roles"))
        
        println parameters.get("lis_person_contact_email_primary")
        
        if(usertype.equals("student")) {
            def studentUser = new SecUser(username: parameters.get("lis_person_contact_email_primary"), password:pw, fromMoodle:true, enabled: 'true').save(failOnError:true)
            Student s1 = new Student(firstName:parameters.get("lis_person_name_given"),surname:parameters.get("lis_person_name_family"),studentId: (int)(Math.random()*1000), email:parameters.get("lis_person_contact_email_primary"),institution:"Second Rate University").save(failOnError:true);
            UserRole.create studentUser, Role.findByAuthority('ROLE_STUDENT')
            studentUser.student = s1
            studentUser.save(flush:true)
        }
        else if(usertype.equals("faculty")) {
            def facultyUser = new SecUser(username: parameters.get("lis_person_contact_email_primary"), password:pw, fromMoodle:true, isFaculty: 'true', isStudent: 'false', enabled: 'true').save(failOnError:true)
            Faculty f1 = new Faculty(title:"Dr", firstName:parameters.get("lis_person_name_given"),surname:parameters.get("lis_person_name_family"), email:parameters.get("lis_person_contact_email_primary"),institution:"Second Rate University").save(failOnError:true);
            UserRole.create facultyUser, Role.findByAuthority('ROLE_FACULTY')
            facultyUser.faculty = f1
            facultyUser.save(flush:true)
        }
    }
    
    public static String generateMoodlePassword(String email, String name) {
        String pwString = email + name
        Integer hash = new Integer(pwString.hashCode())
        
        return hash.toString()
    }
    
    public static String decideUserRole(String roleListStr) {
        String[] roleList = roleListStr.split(",");
        ArrayList<String> SysRole = new ArrayList<String>();
        ArrayList<String> InstRole = new ArrayList<String>();
        ArrayList<String> ConRole = new ArrayList<String>();
        
        for(String role: roleList) {
            if(role.startsWith("urn:lti:sysrole:ims/lis/")) {
                SysRole.add(role.substring(24));
            }
            else if(role.startsWith("urn:lti:instrole:ims/lis/")) {
                InstRole.add(role.substring(25));
            }
            else {
                ConRole.add(role);
            }
        }
        
        if(ConRole.indexOf("Learner") != -1) {
            return "student"
        }
        else if(ConRole.indexOf("Instructor") != -1) {
            return "faculty"
        }
        else {
            throw new MissingPropertyException("User Type")
        }
        
    }
    
   
/**
 * Utility to create OAuth 1 authorization headers.
 *
 * Edited version of code found here:
 * https://gist.github.com/kyrielia/e1e76290416a4faf5f6f
 * @author Kyriacos Elia
 */
    
    public static String generateOAuthSignature(String method, String url, String consumerSecret, Map parameters) {
        
        TreeMap<String,String> encodeParams = new TreeMap<String,String>();
        
        // Each key and value needs to be encoded before being sorted and concatanated
        for(String key: parameters.keySet()) {
            if(!key.equals("oauth_signature")) {
                encodeParams.put(encode(key), encode(parameters.get(key)));
            }
        }
        
        // Sort oAuth params alphabetically
        def sortedParameters = encodeParams.sort { it.key }
        
        def signatureParameters = ''
        sortedParameters.each {
                signatureParameters += "${it.key}=${it.value}&"
        }
        
        // Remove trailing ampersand left from loop
        signatureParameters = signatureParameters.substring(0, signatureParameters.length() - 1)

        def baseString = "${method}&${encode(url)}&${encode(signatureParameters)}"
        
        // Generate HMAC-SHA1
        def keySpec = new SecretKeySpec((consumerSecret + '&').bytes, 'HmacSHA1')
        def mac = Mac.getInstance('HmacSHA1');
        mac.init(keySpec)
        def calculatedBytes = mac.doFinal(baseString.getBytes('UTF-8'))
        
        // Base64 encode the HMAC
        return new String(Base64.encoder.encode(calculatedBytes))
    }

    private static String encode(String stringToEncode) {
        String encodeStr = UriUtils.encode(stringToEncode, "UTF-8");
        encodeStr.replaceAll('%7E', '~');
        encodeStr.replaceAll('\\+', ' ');
        
        return encodeStr
    }
}