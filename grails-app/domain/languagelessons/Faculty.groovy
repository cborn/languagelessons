package languagelessons

class Faculty {
	    
        String title;
        String firstName;
        String surname;
        String university;
        
        static hasMany = [courses:Course]
    
        static belongsTo = SecUser;
        
//        SecUser secUser;
		
        static constraints = {
            courses nullable: true
        }
        
    String getName() {
        firstName + " " + surname ?: "-"
    }
    
    String getFormalName() {
        title + " " + surname ?: "-"
    }
}
