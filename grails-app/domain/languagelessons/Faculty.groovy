package languagelessons

class Faculty {
	    
        String title;
        String firstName;
        String surname;
        String university;
        String email;
        
        static hasMany = [courses:Course]
    
	static belongsTo = SecUser;
		
        static constraints = {
            courses nullable: true
            university nullable: true
        }
        
    String getName() {
        firstName + " " + surname ?: "-"
    }
    
    String getFormalName() {
        title + " " + surname ?: "-"
    }
}
