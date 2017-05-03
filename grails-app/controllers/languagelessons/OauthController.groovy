package languagelessons

class OauthController {

    static allowedMethods = [authorize:'POST']
    
    def ltiService
    
    def authorize() {
        
        TreeMap<String, String> fullMap = new TreeMap<String, String>();
        def xmlMap = request.getParameterMap()
        
        for(String key: xmlMap.keySet()) {
            for(String value: xmlMap.get(key)) {
               fullMap.put(key, value)
            }
        }
        
        fullMap.remove("oauth_signature")
        
        String sig = LtiService.generateOAuthSignature("POST", request.getRequestURL().toString(), "my-secret", fullMap)
        
        if(sig.equals(params.oauth_signature))
            render "Sig"
        else
            render sig + "\n" + params.oauth_signature
    }
}
