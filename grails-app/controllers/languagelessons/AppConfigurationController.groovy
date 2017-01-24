package languagelessons

class AppConfigurationController {

    def index() { }
    
    def getAppImage()
    {   
        response.contentType = AppConfiguration.instance.applicationLogoType;
        response.contentLength = AppConfiguration.instance.applicationLogo.size();
        OutputStream out = response.outputStream;
        out.write(AppConfiguration.instance.applicationLogo);
        out.close();
    }
    
    // allowed profile image file types
    private static final okcontents = ['image/png', 'image/jpeg', 'image/gif'];
    
    def finishConfiguration()
    {
        
        println(params);
        
        // ask user for an image
        def file = request.getFile('image');
        
        println(file.getContentType());
        
        if(!file.getContentType().equalsIgnoreCase("application/octet-stream"))
        {
            // octet-stream means we havent updated the image. 
            // if the type is not ok, give them an error
            if(!okcontents.contains(file.getContentType())) {
               flash.error =  "Picture must be one of the following formats: ${okcontents}";
               redirect(action:"index");
                return
            }
            else {
               // if it's ok, get info about it
                AppConfiguration.instance.applicationLogo = file.bytes;
                AppConfiguration.instance.applicationLogoType = file.contentType;
         }
        }
            // Continue to update the form. 
             
            AppConfiguration.instance.applicationName = params.appName;
            AppConfiguration.instance.applicationDescription = params.appDescription;
            AppConfiguration.instance.emailToSendAs = params.emailToSendAs;
            AppConfiguration.instance.SMTPAddress = params.SMTPAddress;
            AppConfiguration.instance.emailPort = Integer.parseInt(params.SMTPPort);
            AppConfiguration.instance.emailUsername = params.SMTPUsername;
            AppConfiguration.instance.emailPassword = params.SMTPPassword;
            
            
            AppConfiguration.instance.usingMoodle = (params.usingMoodle != null ? params.usingMoodle : false);
            
            if(params.usingMoodle)
            {
                AppConfiguration.instance.moodleHost = params.moodleHost;
                AppConfiguration.instance.moodlePort = params.moodlePort;
                AppConfiguration.instance.moodleDatabaseName = params.moodleDatabaseName;
                AppConfiguration.instance.moodleDBUsername = params.moodleDBName;
                AppConfiguration.instance.moodleDBPassword = params.moodleDBPassword;
               
            }
            
            
            
            AppConfiguration.instance.hasBeenConfigured = true;
            
            if(!AppConfiguration.instance.save(flush:true))
        {
            // give them each error that occurs
            AppConfiguration.instance.errors.each {
                flash.error = it;
            }

            redirect(action:"index");
            return
        }
        else {
            flash.message = "Application has been successfully configured";
            redirect(uri: "/");
            
        }
            
            
        
    }
    
}
