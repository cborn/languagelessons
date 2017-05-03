package languagelessons


import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec
import org.springframework.web.util.UriUtils

/**
 * Utility to create OAuth 1 authorization headers.
 *
 * Edited version of code found here:
 * https://gist.github.com/kyrielia/e1e76290416a4faf5f6f
 * @author Kyriacos Elia
 */

class LtiService {
    
    public static String generateOAuthSignature(String method, String url, String consumerSecret, Map parameters) {
        
        TreeMap<String,String> encodeParams = new TreeMap<String,String>();
        
        // Each key and value needs to be encoded before being sorted and concatanated
        for(String key: parameters.keySet()) {
            encodeParams.put(encode(key), encode(parameters.get(key)));
        }
        
        // Sort oAuth params & additional params alphabetically
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