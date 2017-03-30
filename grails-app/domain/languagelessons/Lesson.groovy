package languagelessons
import static java.util.Calendar.*

class Lesson {
    String name;
    String text;
    int lessonId;
    Date openDate;
    Date dueDate;
    Course course;
    Boolean isArchived = false;
    
    static hasMany = [assignments:Assignment]
    static belongsTo = Course
    static constraints = {
        text nullable: true
        isArchived nullable: true
    }
    
    boolean isOpen() {
        Date now = new Date()
        return now.after(openDate)
    }
    
    boolean isDue() {
        Date now = new Date()
        return now.after(dueDate)
    }
}
