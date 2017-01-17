package languagelessons
import languagelessons.Role
import languagelessons.User
import languagelessons.UserRole

class BootStrap {

    def init = { servletContext ->
        
        def adminRole = new Role(authority: 'ROLE_ADMIN').save()
        def facultyRole = new Role(authority: 'ROLE_FACULTY').save()
        def studentRole = new Role(authority: 'ROLE_STUDENT').save()
        

        if (!User.findByUsername('andrew@email.com') ) {
            def u = new User(username: 'andrew@email.com', password: '#test#')
            u.save()
            UserRole.create u, adminRole
        }

        if (!User.findByUsername('lee@email.com') ) {
            def u = new User(username: 'lee@email.com', password: '#test#')
            u.save()
            UserRole.create u, facultyRole
        }
        
        if (!User.findByUsername('jon@email.com') ) {
            def u = new User(username: 'jon@email.com', password: '#test#')
            u.save()
            UserRole.create u, facultyRole
        }
        
         UserRole.withSession {
         it.flush()
         it.clear()
      }

      assert User.count() == 3
      assert Role.count() == 3
    }

    
    def destroy = {
    }
}
