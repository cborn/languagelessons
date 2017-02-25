package languagelessons

//TODO: Email Class needs finishing

class EmailController {
    
    transient mailService

    def sendEmail(String ) { 
        
    asyncMailService.sendMail {
    // Mail parameters
        try {
            // Email Applicant needs seting up
            mailService.sendMail {
            async true
                to emailTo;
                from "****" //This needs changing to a setting
                subject emailSubject;
                html g.render(template: "/templates/"+emailTemp, model:[email:params.email,link:link,key:key])
                }
        } catch (Exception e) {
            log.error("Failed to send email ${emailTo} ${emailSubject}", e)
        }

    // Additional asynchronous parameters (optional)
    beginDate new Date(System.currentTimeMillis()+60000)    // Starts after one minute, default current date
    endDate new Date(System.currentTimeMillis()+3600000)   // Must be sent in one hour, default infinity
    maxAttemptsCount 3;   // Max 3 attempts to send, default 1
    attemptInterval 300000;    // Minimum five minutes between attempts, default 300000 ms
    delete true;    // Marks the message for deleting after sent
    immediate true;    // Run the send job after the message was created
    priority 10;   // If priority is greater then message will be sent faster
    }

    }
}
