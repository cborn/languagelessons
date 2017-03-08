package languagelessons

class Faculty {
	    
        String title;
        String firstName;
        String surname;
        String institution;
        String email;
        
        static hasMany = [courses:Course]
    
        static belongsTo = SecUser;
        
//        SecUser secUser;
		
        static constraints = {
            courses nullable: true
            institution nullable: true
        }
        
    String getName() {
        firstName + " " + surname ?: "-"
    }
    
    String getFormalName() {
        title + " " + surname ?: "-"
    }
}
