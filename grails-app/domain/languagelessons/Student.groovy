package languagelessons

class Student {
      
        String firstName;
        String middleName;
        String surname;

        static hasMany = [courses:Course]
       
        
	static belongsTo = User;
        
        static constraints = {
            middleName nullable: true
            courses nullable: true
        }
        
    String getName() {
        firstName + " " + surname ?: "-"
    }
    
    /*boolean addToCourse(String courseName) {
        def course = Course.findByName(courseName)
        course.addToStudents(this).save()
    }*/
}
