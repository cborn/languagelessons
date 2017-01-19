package languagelessons



class BootStrap { 

    def init = { servletContext ->
        
        def adminRole = new Role(authority: 'ROLE_ADMIN').save()
        def facultyRole = new Role(authority: 'ROLE_FACULTY').save()
        def studentRole = new Role(authority: 'ROLE_STUDENT').save()
        
        
        
 //           def u = new User(username: 'andrew@email.com', password: '#test#')

 //           u.save()

        
    }
        
   

    def destroy = {
    }
  }
