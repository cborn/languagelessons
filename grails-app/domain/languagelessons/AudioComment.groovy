package languagelessons
import java.util.Base64

class AudioComment extends Comment{
    static String displayName = "Audio Comment"
    static String view = "audioCommentDisplay"
    static String buildView = "audioCommentBuild"
    def getComment() {
        return "data:audio/wav;base64," + audioComment.encodeBase64()
    }
    def putComment(comment) {
        audioComment = comment.replaceAll("data:audio/wav;base64,", "").decodeBase64();
    }
    static constraints = {
    }
}
