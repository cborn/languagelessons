package languagelessons
import static java.util.Calendar.*

class Lesson {
    String name;
    String text;
    Date openDate;
    Date dueDate;
    Course course;
    Boolean isDraft = true;
    Boolean isArchived;
    Lesson template = null;
    
    static hasMany = [assignments:Assignment]
    static belongsTo = Course
    static mapping = {
        text sqlType: 'longText'
    }
    static constraints = {
        template nullable: true
        text nullable: true
        openDate nullable: true
        dueDate nullable: true
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
