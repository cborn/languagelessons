package languagelessons

class OauthController {

    static allowedMethods = [authorize:'POST']
    
    def authorize() {
        println request.getRequestedSessionId()
        
        def people = []
        people << [firstName:'John', lastName:'Doe']
        people << [firstName:'Jane', lastName:'Williams']
        render people as grails.converters.XML
    }
}
