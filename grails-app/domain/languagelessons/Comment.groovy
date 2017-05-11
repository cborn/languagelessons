package languagelessons
import java.util.Date
abstract class Comment {
    abstract def getComment();
    abstract def putComment(comment);
    byte[] audioComment;
    SecUser author;
    String stringComment;
    Date posted;
    Comment commentParent;
    QuestionResult resultParent;
    static types = [StringComment, AudioComment]
    static hasMany = [replies: Comment]
    static belongsTo = [resultParent: QuestionResult,commentParent: Comment]
    static constraints = {
        commentParent nullable: true;
        resultParent nullable: true;
        audioComment maxSize: 1073741824;
        audioComment nullable: true;
        stringComment nullable: true;
    }
}
