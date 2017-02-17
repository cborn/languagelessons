
environments { 
	development {
                    grails {
			mail {
			  host = "localhost"
			  port = 25
			  username = "noreply@carleton.edu"
//			  props = ["mail.smtp.auth":"false",
//					   "mail.smtp.socketFactory.port":"25",
//					   "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
//					   "mail.smtp.socketFactory.fallback":"true"]
                }
	 } 
             grails.mail.disabled = false //Remove emails 
             println("Emails are turned ON. To test emails you need to install a Fake SMTP server")
	}	
}


grails.resources.adhoc.includes = ['/images/**', '/css/**', '/js/**', '/plugins/**', '/fonts/**']
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*', '/fonts/*']


grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.rejectIfNoRule = true


// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'languagelessons.SecUser'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'languagelessons.UserRole'
grails.plugin.springsecurity.authority.className = 'languagelessons.Role'
grails.plugin.springsecurity.securityConfigType = "Annotation"
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	[pattern: '/',               access: ['permitAll']],
	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/index',          access: ['permitAll']],
	[pattern: '/index.gsp',      access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']],
        [pattern:'/**/**/**',        access:['permitAll']]  
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
	[pattern: '/**',             filters: 'JOINED_FILTERS']
]

