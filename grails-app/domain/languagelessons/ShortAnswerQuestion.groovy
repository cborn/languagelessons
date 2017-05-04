package languagelessons

class ShortAnswerQuestion extends Question{
    boolean requiresReview = true;
    static String view = "shortAnswer"
    static String buildView = "buildShortAnswer"
    static String displayName = "Short Answer"
    static def resultType = ShortAnswerResult;
    static Closure<Question> construct = {params ->
        int pointValue = Integer.parseInt(params.pointVal)
        Question q = new ShortAnswerQuestion(question: params.question, 
                                             pointValue: pointValue)
        return q;
    }
    Question fromDraft() {
        Question copy = new ShortAnswerQuestion(question: question, pointValue: pointValue)
        copy.isDraft = false;
        copy.oldId = id;
        return copy;
    }
    static constraints = {
        oldId nullable: true
    }
    boolean grade(String answer) {
        return false;
    }
}
