package languagelessons

class OauthController {

    static allowedMethods = [authorize:'POST']
    
    def ltiService
    
    def authorize() {
        println params.oauth_signature
        
        String sig = LtiService.generateOAuthSignature("POST", request.getRequestURL().toString(), "my-secret", request.getParameterMap())
        
        if(sig.equals(params.oauth_signature))
            render "Siggy"
        else
            render sig + "\n" + params.oauth_signature
    }
}
