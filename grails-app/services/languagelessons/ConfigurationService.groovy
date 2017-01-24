package languagelessons

import grails.transaction.Transactional

@Transactional
class ConfigurationService {
    
    def hasBeenConfigured()
    {
        return AppConfiguration.instance.hasBeenConfigured;
        
    }
    
    def getApplicationName()
    {
        return AppConfiguration.instance.applicationName;
    }
    
    def hasImage()
    {
        return AppConfiguration.instance.applicationLogo != null;
    }
    
    def getDescription()
    {
        return AppConfiguration.instance.applicationDescription;
    }
    
    def getName()
    {
        return AppConfiguration.instance.applicationName;
    }
    
    def getEmailToSendAs()
    {
        return AppConfiguration.instance.emailToSendAs;
    }
    
    
    def getSMTPAddress()
    {
        return AppConfiguration.instance.SMTPAddress;
    }
    
    def getEmailUsername()
    {
        return AppConfiguration.instance.emailUsername;
    }
    
    def getEmailPassword()
    {
        return AppConfiguration.instance.emailPassword;
    }
    
    
    def getEmailPort()
    {
        return AppConfiguration.instance.emailPort > 0 ? AppConfiguration.instance.emailPort : 465 ;
    }
    
    
    def getUsingMoodle()
    {
        return AppConfiguration.instance.usingMoodle;
    }
    
    def getMoodleHost()
    {
        return AppConfiguration.instance.moodleHost;
    }
    
    def getMoodlePort()
    {
        return AppConfiguration.instance.moodlePort;
    }
    
    def getMoodleDatabaseName()
    {
        return AppConfiguration.instance.moodleDatabaseName;
    }
    
    
    def getMoodleDBUsername()
    {
        return AppConfiguration.instance.moodleDBUsername;
    }
    
    def getMoodleDBPassword()
    {
        return AppConfiguration.instance.moodleDBPassword;
    }
    
    
    
}

