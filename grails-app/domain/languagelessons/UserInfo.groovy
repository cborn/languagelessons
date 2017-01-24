package languagelessons

class UserInfo {
	    
        String title;
        String firstName;
        String middleName;
        String surname;
        
        String university;
        String workTelNumber;
        
        static hasMany = [courses:Course]
    
	static belongsTo = User;
		
        static constraints = {
            university nullable: true
            courses nullable: true
            middleName nullable: true
        }
        
    String getName() {
        firstName + " " + surname ?: "-"
    }
    
    String getFormalName() {
        title + " " + surname ?: "-"
    }
}
