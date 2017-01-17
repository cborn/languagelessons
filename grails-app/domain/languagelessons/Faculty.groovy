package languagelessons

class Faculty {
	    
        String title;
        String firstName;
        String surname;
        
        String university;
 //       Address address;
        
        String personalTelNumberCountry;
        String personalTelNumber;
        
        String workTelNumberCountry;
        String workTelNumber;
        
        String fieldTelNumberCountry;
        String fieldTelNumber;
        
        static hasMany = [courses:Course]
    
	static belongsTo = User;
		
        static constraints = {
            university nullable: true
            address nullable: true
            courses nullable: true
            personalTelNumberCountry nullable: true
            personalTelNumber nullable: true
            workTelNumberCountry nullable: true
            workTelNumber nullable: true
            fieldTelNumberCountry nullable: true
            fieldTelNumber nullable: true
            primaryContact nullable: true
        }
        
    String getName() {
        firstName + " " + surname ?: "-"
    }
    
    String getFormalName() {
        title + " " + surname ?: "-"
    }
}
