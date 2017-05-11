package languagelessons

class StringComment extends Comment{
    static String displayName = "Text Comment"
    static String view = "stringCommentDisplay"
    static String buildView = "stringCommentBuild"
    def getComment() {
        return stringComment
    }
    def putComment(comment) {
        stringComment = comment
    }
    static constraints = {
    }
}
