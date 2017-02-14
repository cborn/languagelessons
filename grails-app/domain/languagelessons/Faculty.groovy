package languagelessons

class Faculty {
	    
        String title;
        String firstName;
        String surname;
        
        static hasMany = [courses:Course]
    
	static belongsTo = User;
		
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
