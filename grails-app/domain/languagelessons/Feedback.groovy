package languagelessons

class Feedback {
    
    Student student;
    Lesson lesson;
    
    Date date;
    String description;
    User author;
    
    boolean removedEvent = false;
    
    static belongsTo = Student;
    
    static constraints = {
        description maxSize: 1000
        description nullable:true
        application nullable: true
    }
	
    static mapping = {
        removedEvent defaultValue: false
    }

}
