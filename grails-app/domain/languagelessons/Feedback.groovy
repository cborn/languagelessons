package languagelessons

class Feedback {
    
    Student student;
    Lesson lesson;
    
    Date date;
    String description;
    SecUser author;
    
    // Time frame for comment
    Float startTime;
    Float endTime;
    
    boolean removedEvent = false;
    
    static belongsTo = Student;
    
    static constraints = {
        description maxSize: 1000
        description nullable:true
    }
	
    static mapping = {
        removedEvent defaultValue: false
    }

}
