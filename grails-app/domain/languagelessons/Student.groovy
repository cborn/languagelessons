package languagelessons

class Student {
      
        String firstName;
        String middleName;
        String surname;
        String institution;
        int studentId;
        static hasMany = [courses: Course]
	static belongsTo = SecUser;
        
        static constraints = {
            studentId unique:true
            middleName nullable: true
            courses nullable: true
            institution nullable: true
        }
        
    String getName() {
        firstName + " " + surname ?: "-"
    }
}
