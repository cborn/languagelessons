package languagelessons
import static java.util.Calendar.*

class Lesson {
    String name;
    String text;
    Date openDate;
    Date dueDate;
    Course course;
    static constraints = {
        text nullable: true
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
