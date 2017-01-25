package languagelessons

class Questions {
    
    String question;
    String type;
    Boolean archived = false;
    
//    static hasMany = [lessons:Lesson];
    
    static belongsTo = Lesson;
    
    static constraints = {
        question maxSize: 5000
//        lessons nullable: true
        archived nullable: true
    }
}
