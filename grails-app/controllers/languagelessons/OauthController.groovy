package languagelessons

class OauthController {

    static allowedMethods = [authorize:'POST']
    
    def ltiService
    
    def authorize() {
        
//        TreeMap<String, String> fullMap = new TreeMap<String, String>();
//        def xmlMap = request.getParameterMap()
//        
//        for(String key: xmlMap.keySet()) {
//            fullMap.put(key, xmlMap.get(key))
//        }
//        
//        fullMap.remove("oauth_signature")
//        
//        Set<Set<Map.Entry<String,String>>> pSet = ltiService.powerSet(fullMap.entrySet());
//        
//        println pSet.size();
//        
//        for(Set<Map.Entry<String,String>> s: pSet) {
//            if (s.isEmpty())
//                continue;
//            
//            TreeMap<String,String> curMap = new TreeMap<String,String>();
//            for(Map.Entry<String,String> entry: s)
//                curMap.add(entry.getKey(), entry.getValue());
//            String secret = LtiService.generateOAuthSignature("POST", request.getRequestURL().toString(), "my-secret", curMap)
//            println secret
//            if(params.oauth_signature.equals(secret))
//                println curMap;
//        }
//        
//        TreeMap<String, String> oauthMap = new TreeMap<String, String>();
//        
        def xmlMap = request.getParameterMap()
//        
        for(String key: xmlMap.keySet())
        {
//            if(key.startsWith("oauth") && !key.equals("oauth_signature")) {
//                oauthMap.put(key, xmlMap.get(key))
//                println "       " + key + oauthMap.get(key)
//            }
//            if(!key.equals("oauth_signature")) {
//                fullMap.put(key, xmlMap.get(key))
//            }
//            
            println key + ": " + xmlMap.get(key)
        }
//        
//        println "\n\n\n"
//        
//        println LtiService.generateOAuthSignature("POST", request.getRequestURL().toString(), "my-secret", oauthMap)

//        TreeMap<String, String> testMap = new TreeMap<String, String>();
//        
//        testMap.put("oauth_consumer_key", "key")
//        testMap.put("oauth_nonce", "nonce")
//        testMap.put("oauth_signature_method", "HMAC-SHA1")
//        testMap.put("oauth_timestamp", "123456789")
//        testMap.put("oauth_token", "token")
//        
//        println LtiService.generateOAuthSignature("POST", "http://example.com/wp-json/wp/v2/posts", "abcd", testMap)
//
//        TreeMap<String, String> setMap = new TreeMap<String, String>();
//        setMap.put("1", "v1");
//        setMap.put("2", "v2")
//        setMap.put("3", "v3")
//        
//        Set<Set<Map.Entry<String,String>>> pSet = ltiService.powerSet(setMap.entrySet());
//        
//        for(Set<Map.Entry<String,String>> s: pSet) {
//            println s
//        
//        }
            
        
        render "Siggy"
    }
}
