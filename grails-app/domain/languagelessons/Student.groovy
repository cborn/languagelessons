package languagelessons

class Student {
      
        String firstName;
        String middleName;
        String surname;
        String university;

//        static hasMany = [courses:Course]
       
	static belongsTo = SecUser;
        
        static constraints = {
            middleName nullable: true
 //           courses nullable: true
            university nullable: true
        }
        
    String getName() {
        firstName + " " + surname ?: "-"
    }
    

}
