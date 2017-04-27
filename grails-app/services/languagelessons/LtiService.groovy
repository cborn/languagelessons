package languagelessons

import org.apache.commons.lang.RandomStringUtils

import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec

/**
 * Utility to create OAuth 1 authorization headers.
 *
 * Edited version of code found here:
 * https://gist.github.com/kyrielia/e1e76290416a4faf5f6f
 * @author Kyriacos Elia
 */

class LtiService {
    def test() {
        return "string"
    }
    
    public static Set<Set<Map.Entry<String,String>>> powerSet(Set<Map.Entry<String,String>> originalSet) {
        Set<Set<Map.Entry<String,String>>> sets = new HashSet<Set<Map.Entry<String,String>>>();
        if (originalSet.isEmpty()) {
            sets.add(new HashSet<Map.Entry<String,String>>());
            return sets;
        }
        List<Map.Entry<String,String>> list = new ArrayList<Map.Entry<String,String>>(originalSet);
        Map.Entry<String,String> head = list.get(0);
        Set<Map.Entry<String,String>> rest = new HashSet<Map.Entry<String,String>>(list.subList(1, list.size()));
        for (Set<Map.Entry<String,String>> set : powerSet(rest)) {
            Set<Map.Entry<String,String>> newSet = new HashSet<Map.Entry<String,String>>();
            newSet.add(head);
            newSet.addAll(set);
            sets.add(newSet);
            sets.add(set);
        }
        return sets;
    }
    
    public static String generateOAuthAuthorizationHeader(String method, String url, String consumerKey, String consumerSecret) {

		generateOAuthAuthorizationHeader(method, url, consumerKey, consumerSecret, [:])
	}
    
    public static String generateOAuthAuthorizationHeader(String method, String url, String consumerKey, String consumerSecret, Map additionalParameters) {

        def signatureMethod = 'HMAC-SHA1'
        def version = '1.0'

        // Get timestamp in seconds
        def timestamp = "${Math.round(new Date().getTime()/1000)}";

        // OAuth nonce consists of 6 randomly generated characters, which must be unique for each request.
        def nonce = RandomStringUtils.random(6, true, true)

        def oAuthParameters = [
                        oauth_consumer_key: consumerKey,
                        oauth_nonce: nonce,
                        oauth_signature_method: signatureMethod,
                        oauth_timestamp: timestamp,
                        oauth_version: version
        ]

        // Combine oAuth parameters and additional request parameters to generate signature
        def signature = generateOAuthSignature(method, url, consumerSecret, oAuthParameters + additionalParameters)

        "OAuth oauth_consumer_key=\"${consumerKey}\"," +
                        "oauth_signature_method=\"${signatureMethod}\"," +
                        "oauth_timestamp=\"${timestamp}\"," +
                        "oauth_nonce=\"${nonce}\"," +
                        "oauth_version=\"${version}\"," +
                        "oauth_signature=\"${encode(signature)}\""
        
        return "success"
    }

    public static String generateOAuthSignature(String method, String url, String consumerSecret, Map parameters) {
        // Sort oAuth params & additional params alphabetically
        def sortedParameters = parameters.sort { it.key }
        
        for(String key:sortedParameters.keySet())
            println key + ": " + sortedParameters.get(key)

        def signatureParameters = ''
        sortedParameters.each {
                signatureParameters += "${it.key}=${it.value}&"
        }

        // Remove trailing ampersand left from loop
        signatureParameters = signatureParameters.substring(0, signatureParameters.length() - 1)

        def baseString = "${method}&${encode(url)}&${encode(signatureParameters)}"
        
        println "   " + baseString

        // Generate HMAC-SHA1
        def keySpec = new SecretKeySpec((consumerSecret + '&').bytes, 'HmacSHA1')
        def mac = Mac.getInstance('HmacSHA1');
        mac.init(keySpec)
        def calculatedBytes = mac.doFinal(baseString.getBytes('UTF-8'))

        println "     " + calculatedBytes
        // Base64 encode the HMAC
        return new String(Base64.encoder.encode(calculatedBytes))
    }

    private static String encode(String stringToEncode) {

        URLEncoder.encode(stringToEncode, 'UTF-8')
    }
}