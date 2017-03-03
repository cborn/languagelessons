package languagelessons

class Student {
      
        String firstName;
        String middleName;
        String surname;
        String university;
        int studentId;
        static hasMany = [courses: Course]
	static belongsTo = SecUser;
        
        static constraints = {
            studentId unique:true
            middleName nullable: true
            courses nullable: true
            university nullable: true
        }
        
    String getName() {
        firstName + " " + surname ?: "-"
    }
}
