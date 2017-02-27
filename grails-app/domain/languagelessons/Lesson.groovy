package languagelessons
import static java.util.Calendar.*

class Lesson {
    String name;
    String text;
    Date openDate;
    Date dueDate;
    static belongsTo = Course;
    static constraints = {
    }
}
