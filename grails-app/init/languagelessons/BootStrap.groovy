package languagelessons


class BootStrap { 

    def init = {
        
        def adminRole = new Role(authority: 'ROLE_ADMIN').save()
        def facultyRole = new Role(authority: 'ROLE_FACULTY').save()
        def studentRole = new Role(authority: 'ROLE_STUDENT').save()
        
        
        
        // Test Admin User  %%%%%%%%%%%%%%%%%//
           def adminUser = new User(username: 'andrew@test.com', password: 'password').save()
           UserRole.create adminUser, adminRole
        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
        // Test Faculty User  %%%%%%%%%%%%%%%%%//
           def facultyUser = new User(username: 'lee@test.com', password: 'password').save()
           UserRole.create facultyUser, facultyRole
        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
        // Test Student User  %%%%%%%%%%%%%%%%%//
           def studentUser = new User(username: 'joe@test.com', password: 'password').save()
           UserRole.create studentUser, studentRole
        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
        
            
 
 UserRole.withSession {
         it.flush()
         it.clear()
      }
        
    }

    def destroy = {
    }
  }
