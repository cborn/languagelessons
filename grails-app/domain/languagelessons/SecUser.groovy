package languagelessons

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@EqualsAndHashCode(includes='username')
@ToString(includes='username', includeNames=true, includePackage=false)
class SecUser implements Serializable {

   private static final long serialVersionUID = 1

   transient springSecurityService

    String resetKey;
    String k;
    String username
    String password
    boolean enabled = false   // Change this before going to production
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    Student student
    Faculty faculty
    boolean isStudent = true;
    boolean isFaculty = false;
    boolean fromMoodle = false;
    Date lastLoginTime;

        // Added some methods for easy name retrieval - just ask the User!
	// user.getFullName() 
	String getFullName() {
            if(isStudent) {
                student?.firstName + " " + student?.surname ?: "-"
            }
            else if(isFaculty) {
                faculty?.firstName + " " + faculty?.surname ?: "-"
            }
            else {
                "-"
            }
        }
        // user.getFirstName()
        String getFirstName() {
            if(isStudent) {
                student?.firstName ?: "-"
            }
            else if(isFaculty) {
                faculty?.firstName ?: "-"
            }
            else {
                "-"
            }
        }
        // user.getSurname()
        String getSurname() {
            if(isStudent) {
                student?.surname ?: "-"
            }
            else if(isFaculty) {
                faculty?.surname ?: "-"
            }
            else {
                "-"
            }
        }
        
        boolean checkIfStudent () {
            return isStudent;
        }
        
        Student getStudent () {
            return student;
        }
        
        
    
    
    SecUser(String username, String password) {
            this()
            this.username = username
            this.password = password
    }

    @Override
    int hashCode() {
            username?.hashCode() ?: 0
    }

    @Override
    boolean equals(other) {
            is(other) || (other instanceof SecUser && other.username == username)
    }

    @Override
    String toString() {
            username
    }
    
    
   Set<Role> getAuthorities() {
      UserRole.findAllByUser(this)*.role
   }

   def beforeInsert() {
      encodePassword()
   }

   def beforeUpdate() {
      if (isDirty('password')) {
         encodePassword()
      }
   }

   protected void encodePassword() {
      password = springSecurityService?.passwordEncoder ?
            springSecurityService.encodePassword(password) :
            password
   }

   static transients = ['springSecurityService']

   static constraints = {
        password blank: false, password: true
        username blank: false, unique: true
        faculty nullable:true, unique: true
        student nullable:true, unique: true
        k nullable: true
        resetKey nullable: true
        lastLoginTime nullable: true
   }

   static mapping = {
      password column: '`password`'
   }
}
